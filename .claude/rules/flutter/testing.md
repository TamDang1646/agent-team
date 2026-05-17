> This file extends [common/testing.md](../../common/testing.md) with Flutter-specific testing.

# Flutter Testing

## Priority Order

### 1. Widget Tests

Test individual widgets with full Flutter testing harness.

### 2. Integration Tests

Test complete user flows.

### 3. Unit Tests

Test business logic, services, repositories.

## Testing Widget States

Test all widget states: loading, error, success, empty.

## Mocking Dependencies

Use mockito or mocktail for dependencies.

## Golden Tests

For visual regression testing of design system components.

## Test Command Reference

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget/login_test.dart

# Run integration tests
flutter test integration_test/

# Generate golden files
flutter test --update-goldens
```

## Testing Minimum Coverage

- Unit tests: 80%+ for business logic
- Widget tests: Critical UI components
- Integration tests: All user journeys
- Golden tests: Design system components