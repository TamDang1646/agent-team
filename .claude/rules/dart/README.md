# Dart Rules

Dart language-specific rules for the Agent Team system.

## Files

- **coding-style.md** - Dart coding conventions, null safety, async patterns
- **testing.md** - Unit tests, widget tests, integration tests with mockito/mocktail
- **performance.md** - Dart/Flutter performance targets and optimization
- **patterns.md** - State management (Riverpod, BLoC, Provider), repository pattern
- **hooks.md** - Auto-format, analyze, and build verification hooks
- **security.md** - Secret management, secure storage, platform channel security

## Quick Reference

```bash
# Format code
dart format .

# Analyze code
dart analyze

# Run tests
flutter test

# Build debug
flutter build apk --debug
```

## State Management Options

| Approach | Best For |
|----------|----------|
| setState | Local widget state |
| Provider | Small-medium apps |
| Riverpod | Medium-large apps |
| BLoC | Enterprise apps |