---
name: flutter
description: Flutter UI framework patterns, widget architecture, and best practices
when_to_use: Flutter app development, cross-platform mobile UI, web/desktop with Flutter
---

# Flutter Skill

## Widget Architecture

### StatelessWidget vs StatefulWidget

```dart
// Use StatelessWidget when widget has no internal state
class Greeting extends StatelessWidget {
  final String name;
  const Greeting({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text('Hello, $name');
  }
}

// Use StatefulWidget when widget needs mutable state
class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _increment,
      child: Text('Count: $_count'),
    );
  }
}
```

### Const Constructors

Always use const for widgets that don't change:

```dart
// WRONG
Text('Hello')

// CORRECT
const Text('Hello')
```

## State Management

### Provider Pattern

```dart
// Define a ChangeNotifier
class CounterModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

// Wrap app with Provider
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CounterModel(),
      child: MyApp(),
    ),
  );
}

// Consume in widget
class CounterDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterModel>();
    return Text('Count: ${counter.count}');
  }
}
```

### Riverpod Pattern

```dart
// Define a provider
final counterProvider = StateProvider<int>((ref) => 0);

// Consume in widget
class CounterDisplay extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return GestureDetector(
      onTap: () => ref.read(counterProvider.notifier).state++,
      child: Text('Count: $count'),
    );
  }
}
```

## Navigation

### GoRouter Setup

```dart
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return DetailsScreen(id: id!);
      },
    ),
  ],
);

// Navigate
context.go('/details/123');
context.push('/details/123');
context.pop();
```

## Forms

```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter email';
          }
          if (!value.contains('@')) {
            return 'Invalid email';
          }
          return null;
        },
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Form is valid
          }
        },
        child: Text('Submit'),
      ),
    ],
  ),
);
```

## Common Widgets

### ListView.builder

```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      key: ValueKey(items[index].id),
      title: Text(items[index].name),
    );
  },
);
```

### FutureBuilder

```dart
FutureBuilder<User>(
  future: fetchUser(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    if (!snapshot.hasData) {
      return Text('No user found');
    }
    return Text(snapshot.data!.name);
  },
);
```

### StreamBuilder

```dart
StreamBuilder<List<Message>>(
  stream: messagesStream,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return ListView(
        children: snapshot.data!
            .map((msg) => MessageTile(msg))
            .toList(),
      );
    }
    return CircularProgressIndicator();
  },
);
```

## Lifecycle

### StatefulWidget Lifecycle

1. `createState()` - Widget created
2. `initState()` - One-time initialization
3. `build()` - Render UI
4. `didUpdateWidget()` - Handle props changes
5. `dispose()` - Cleanup (cancel streams, controllers)

```dart
@override
void initState() {
  super.initState();
  _controller = AnimationController(...);
  _loadData();
}

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

## Performance Tips

1. Use `const` constructors where possible
2. Use `ListView.builder` for long lists
3. Extract widgets with independent state
4. Avoid `setState` on entire widget tree
5. Use `RepaintBoundary` for expensive widgets
6. Cache images with `cached_network_image`