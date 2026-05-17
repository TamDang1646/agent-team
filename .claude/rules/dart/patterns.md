> This file extends [common/patterns.md](../../common/patterns.md) with Dart-specific patterns.

# Dart Patterns

## State Management

Choose based on app complexity:

| Approach | When to Use |
|----------|-------------|
| `setState` | Local widget state, simple counters |
| `Provider` | Small-medium apps, simple state sharing |
| `Riverpod` | Medium-large apps, compile-time safety |
| `BLoC` | Enterprise apps, testable business logic |
| `GetX` | Rapid prototyping (use cautiously) |

### Riverpod Pattern

```dart
final userProvider = StateProvider<User?>((ref) => null);

class UserProfile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Text(user?.name ?? 'Loading');
  }
}
```

### BLoC Pattern

```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<IncrementEvent>((e, emit) => emit(state + 1));
  }
}
```

## Repository Pattern

Encapsulate data access:

```dart
abstract class UserRepository {
  Future<User?> getUser(String id);
  Future<void> updateUser(User user);
  Stream<User> watchUser(String id);
}

class CachedUserRepository implements UserRepository {
  final ApiRepository _api;
  final LocalCache _cache;

  CachedUserRepository(this._api, this._cache);

  @override
  Future<User?> getUser(String id) async {
    final fromCache = _cache.get<User>(id);
    if (fromCache != null) return fromCache;

    final fromApi = await _api.fetchUser(id);
    _cache.set(id, fromApi);
    return fromApi;
  }
}
```

## Dependency Injection

Use `get_it` or Riverpod for DI:

```dart
final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<Api>(() => ApiClient());
  getIt.registerLazySingleton<UserRepository>(() => CachedUserRepository(getIt()));
}
```

## Error Handling Patterns

Use sealed classes for result types:

```dart
sealed class Result<T> {
  factory Result.success(T data) = Success;
  factory Result.failure(String message) = Failure;
}

final class Success<T> implements Result<T> {
  final T data;
  Success(this.data);
}

final class Failure<T> implements Result<T> {
  final String message;
  Failure(this.message);
}
```

## Widget Composition

Prefer composition over inheritance:

```dart
// WRONG: Inheritance
class FancyButton extends CustomButton { ... }

// CORRECT: Composition
class FancyButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const FancyButton({required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      child: child,
      onPressed: onPressed,
      style: _fancyStyle,
    );
  }
}
```

## Key Patterns

Always use keys for list items and dynamic content.