> This file extends [common/coding-style.md](../../common/coding-style.md) with Dart-specific patterns.

# Dart Coding Style

## Null Safety (CRITICAL)

Dart's null safety is mandatory. Never use `!` unless you 100% control the code path.

```dart
// WRONG: Blind null assertion
String name = user.getName()!;

// CORRECT: Safe null handling
String? maybeName = user.getName();
String displayName = maybeName ?? 'Anonymous';

// CORRECT: Early return
String getName(User? user) {
  if (user == null) return 'Guest';
  return user.name;
}
```

## Async/Await Patterns

Always use async/await over raw Future chaining.

```dart
// WRONG: Nested then chains
fetchData().then((data) => process(data).then((result) => save(result)));

// CORRECT: Async/await
Future<void> loadData() async {
  final data = await fetchData();
  final result = await process(data);
  await save(result);
}
```

## Collection Literals

Use spread operators and collection-if for conditional rendering.

```dart
final items = [
  headerWidget,
  if (showFooter) footerWidget,
  ...extraItems,
];
```

## Extension Methods

Use extensions to add functionality without inheritance.

```dart
extension StringExtensions on String {
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@[\w-]+\.[\w-]+').hasMatch(this);
  }
}
```

## Naming Conventions

- Variables/functions: `camelCase`
- Classes/typedefs: `PascalCase`
- Constants: `kConstantName` (leading k)
- Private members: `_underscore` prefix
- Files: `snake_case.dart`

## Error Handling

Use `try-catch` with specific exception types.

```dart
try {
  await api.call();
} on NetworkException catch (e) {
  _handleNetworkError(e);
} on ParseException catch (e) {
  _handleParseError(e);
} catch (e, stackTrace) {
  _logUnexpected(e, stackTrace);
  rethrow;
}
```

## Code Smells to Avoid

### Deep Widget Trees

Refactor when a build method exceeds 50 lines or nests over 5 levels deep.

```dart
// WRONG: Deep nesting
return Container(
  child: Padding(
    child: Row(
      children: [
        Column(
          children: [
            // Too deep!
          ],
        ),
      ],
    ),
  ),
);

// CORRECT: Extract to named methods or separate widgets
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: _buildBody(context),
  );
}

Widget _buildBody(BuildContext context) {
  return _buildRow(context);
}
```

### Missing Const Constructors

Always use `const` where possible for compile-time widgets.

```dart
// WRONG: Runtime recreation
Text('Hello')

// CORRECT: Compile-time constant
const Text('Hello')
```

## Dart Code Quality Checklist

- [ ] Null safety fully utilized (no unnecessary `!`)
- [ ] Async code uses async/await
- [ ] Const constructors used for static widgets
- [ ] Extension methods over utility classes
- [ ] No widget trees deeper than 20 levels
- [ ] Private members prefixed with `_`
- [ ] Constants use `k` prefix