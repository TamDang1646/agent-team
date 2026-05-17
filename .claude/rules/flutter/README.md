# Flutter Rules

Flutter UI framework rules for the Agent Team system.

## Files

- **coding-style.md** - Widget structure, const constructors, naming conventions
- **testing.md** - Widget tests, integration tests, golden tests
- **performance.md** - 60fps targets, frame rendering, bundle budgets
- **patterns.md** - Widget composition, navigation (GoRouter), forms
- **hooks.md** - Auto-format, analyze, test, and build verification hooks
- **security.md** - Secret management, certificate pinning, code obfuscation

## Quick Reference

```bash
# Format code
flutter format .

# Analyze code
flutter analyze

# Run tests
flutter test

# Build debug APK
flutter build apk --debug

# Profile performance
flutter run --profile
```

## Widget Extraction Rules

Extract widget when:
- Build method exceeds 50 lines
- Same pattern appears 3+ times
- Widget has independent state
- Nesting exceeds 5 levels

## Performance Checklist

- [ ] Const constructors used
- [ ] ListView.builder for lists
- [ ] Images have dimensions
- [ ] No unnecessary setState
- [ ] Animations use transform/opacity