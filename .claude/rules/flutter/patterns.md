> This file extends [common/patterns.md](../../common/patterns.md) with Flutter-specific patterns.

# Flutter Patterns

## Widget Composition

Use compound widgets when related UI shares state.

## State Management Patterns

### Provider Pattern

For small-medium apps with simple state sharing.

### Riverpod Pattern

For medium-large apps with compile-time safety.

## Navigation Patterns

### GoRouter Pattern

```dart
final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(
      path: '/profile/:userId',
      builder: (context, state) => ProfileScreen(
        userId: state.pathParameters['userId']!,
      ),
    ),
  ],
);
```

## Form Handling

Use GlobalKey<FormState> with TextFormField validators.

## Data Fetching Patterns

### AsyncState Pattern

```dart
sealed class AsyncState<T> {
  const factory AsyncState.initial() = AsyncInitial;
  const factory AsyncState.loading() = AsyncLoading<T>;
  const factory AsyncState.data(T data) = AsyncData<T>;
  const factory AsyncState.error(String message) = AsyncError<T>;
}
```

### Repository Pattern

Encapsulate data access behind abstract interfaces.

## Dependency Injection

Use `get_it` or Riverpod for dependency injection.

## Key Usage

Always use keys for dynamic lists to preserve widget state.