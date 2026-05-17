> This file extends [common/coding-style.md](../../common/coding-style.md) with Flutter-specific UI patterns.

# Flutter Coding Style

## Widget Structure

Organize by feature, not by type:

```text
lib/
├── features/
│   ├── auth/
│   │   ├── login/
│   │   │   ├── login_screen.dart
│   │   │   ├── login_form.dart
│   │   │   └── login_controller.dart
│   │   └── register/
│   └── home/
├── shared/
│   ├── widgets/
│   ├── themes/
│   └── utils/
```

## Const Constructors (CRITICAL)

Always use const for static widgets.

## Widget Extraction Rules

Extract when:
- Build method exceeds 50 lines
- Same widget pattern appears 3+ times
- Widget has independent state
- Build has nesting over 5 levels

## Naming Conventions

- Widgets: `PascalCase` (`UserProfile`, `LoginButton`)
- Widget state: `_${WidgetName}State`
- Files: `snake_case` (`user_profile.dart`)
- Test files: `*_test.dart` or `*_widget_test.dart`

## Layout Patterns

Prefer composable layouts over deeply nested containers.

## Theming

Use ThemeData consistently; never hardcode colors or spacing.

## Code Quality Checklist

- [ ] Const constructors used where possible
- [ ] Build methods under 50 lines
- [ ] Widget tree depth under 20 levels
- [ ] Keys used for dynamic lists
- [ ] Proper disposal of controllers
- [ ] Follows feature-based organization
- [ ] Theme tokens used, not hardcoded values