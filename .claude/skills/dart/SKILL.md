---
name: dart
description: Dart language patterns, idioms, and best practices
when_to_use: Dart development, backend services, CLI tools, serverless functions
---

# Dart Skill

## Language Fundamentals

### Null Safety

- Non-nullable by default
- Use `?` for nullable types
- Use `!` only when certain of non-null
- Use `??` for default values
- Use `?.` for safe access

### Async Programming

- `Future<T>` for async operations
- `await` for waiting on futures
- `async` keyword for async functions
- `Stream<T>` for streaming data
- `StreamController` for creating streams

### Collections

- Lists: `List<int> numbers = [1, 2, 3];`
- Maps: `Map<String, int> scores = {'Alice': 100};`
- Sets: `Set<String> names = {'Alice', 'Bob'};`
- Spread operator: `...` for merging
- Collection-if: `if (condition) element`

### Extensions

```dart
extension StringExtensions on String {
  bool get isValidEmail => RegExp(...).hasMatch(this);
  String get capitalized => this[0].toUpperCase() + substring(1);
}
```

### Pattern Matching (Dart 3+)

```dart
switch (value) {
  case int():
    print('Integer');
  case String():
    print('String');
  default:
    print('Unknown');
}
```

## Common Patterns

### Singleton

```dart
class Singleton {
  static final Singleton _instance = Singleton._internal();
  factory Singleton() => _instance;
  Singleton._internal();
}
```

### Factory Constructor

```dart
class Logger {
  static final Map<String, Logger> _cache = {};

  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }
}
```

### Mixins

```dart
mixin Logging {
  void log(String message) => print('[LOG] $message');
}

class Service with Logging {
  void doWork() {
    log('Doing work');
  }
}
```

## Error Handling

```dart
try {
  await riskyOperation();
} on SpecificException catch (e) {
  handleSpecificError(e);
} catch (e, stackTrace) {
  logUnexpected(e, stackTrace);
  rethrow;
} finally {
  cleanup();
}
```

## Testing

```dart
import 'package:test/test.dart';

void main() {
  group('MyClass', () {
    late MyClass instance;

    setUp(() {
      instance = MyClass();
    });

    tearDown(() {
      instance.dispose();
    });

    test('does something', () {
      expect(instance.result, equals(expected));
    });
  });
}
```