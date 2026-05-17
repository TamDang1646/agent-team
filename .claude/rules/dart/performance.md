> This file extends [common/performance.md](../../common/performance.md) with Dart-specific content.

# Dart Performance

## Flutter Core Performance Targets

| Metric | Target |
|--------|--------|
| App startup time | under 2s cold, under 1s warm |
| Frame rendering | 16ms (60fps) |
| Jank events | 0 on scroll |
| Memory usage | under 200MB typical |
| Isolate CPU usage | under 30% sustained |

## Bundle Budget

| Type | Budget |
|------|--------|
| Minimum Flutter app | under 10MB |
| Typical mobile app | under 20MB |
| Full-featured app | under 50MB |

## Loading Strategy

1. Defer non-essential packages using deferred loading
2. Use `const` constructors for static widgets
3. Precompute expensive values during app initialization

```dart
// Deferred loading example
import 'package:heavy_module/heavy_module.dart' deferred as heavy;

Future<void> loadHeavyModule() async {
  await heavy.loadLibrary();
  heavy.heavyFeature();
}
```

## Animation Performance

- Animate only `opacity` and `transform`
- Use `AnimatedContainer` for simple animations
- Use `AnimationController` with `TickerProviderStateMixin` for complex
- Avoid `setState` in animation loops

## List Performance

Use `ListView.builder` with keys for dynamic lists.

```dart
// WRONG: Building all items
ListView(
  children: items.map((item) => ItemWidget(item)).toList(),
)

// CORRECT: Lazy building
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemWidget(items[index]),
)
```

## Performance Checklist

- [ ] All animations use transform/opacity only
- [ ] Const constructors used where possible
- [ ] List views use itemBuilder pattern
- [ ] Expensive computations run in isolates
- [ ] Images have fixed dimensions
- [ ] No unnecessary `setState` calls
- [ ] Heavy operations deferred until needed