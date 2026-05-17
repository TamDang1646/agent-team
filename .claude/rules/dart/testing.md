> This file extends [common/testing.md](../../common/testing.md) with Dart-specific patterns.

# Dart Testing

## Test Types

### Unit Tests

Test individual functions, services, and models.

```dart
test('calculateTotal returns correct sum', () {
  // Arrange
  final items = [10, 20, 30];

  // Act
  final result = calculateTotal(items);

  // Assert
  expect(result, equals(60));
});
```

### Widget Tests

Test individual widgets in isolation.

```dart
testWidgets('TextField displays entered text', (tester) async {
  await tester.pumpWidget(MyApp());

  await tester.enterText(find.byType(TextFormField), 'Hello');
  await tester.pump();

  expect(find.text('Hello'), findsOneWidget);
});
```

### Integration Tests

Test complete app flows.

```dart
testWidgets('User can login and see dashboard', (tester) async {
  await tester.pumpWidget(MyApp());

  await tester.enterText(find.byKey(kUsernameField), 'user');
  await tester.enterText(find.byKey(kPasswordField), 'pass');
  await tester.tap(find.byType(ElevatedButton));
  await tester.pumpAndSettle();

  expect(find.text('Dashboard'), findsOneWidget);
});
```

## Test Organization

```dart
group('UserService', () {
  late UserService service;

  setUp(() {
    service = UserService(mockApi);
  });

  tearDown(() {
    service.dispose();
  });

  test('fetchUser returns user data', () async {
    // Test implementation
  });
});
```

## Mocking Patterns

Use `mockito` or `mocktail` for dependencies.

```dart
class MockApi extends Mock implements Api {}

test('fetchData calls API and returns result', () async {
  final mockApi = MockApi();
  when(mockApi.getData()).thenAnswer((_) async => 'data');

  final service = DataService(mockApi);
  final result = await service.fetchData();

  verify(mockApi.getData()).called(1);
  expect(result, 'data');
});
```

## Minimum Test Coverage: 80%

Dart/Flutter projects must maintain 80%+ test coverage.

Test Types (ALL required):
1. **Unit Tests** - Services, repositories, models, utilities
2. **Widget Tests** - Critical UI components
3. **Integration Tests** - User flows (login, checkout, etc.)

## Test-Driven Development

Mandatory workflow:
1. Write test first (RED)
2. Run test - it should FAIL
3. Write minimal implementation (GREEN)
4. Run test - it should PASS
5. Refactor (IMPROVE)
6. Verify coverage (80%+)

Run tests:
```bash
flutter test
flutter test --coverage
```