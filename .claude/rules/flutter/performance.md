> This file extends [common/performance.md](../../common/performance.md) with Flutter-specific content.

# Flutter Performance

## Core Performance Targets

| Metric | Target |
|--------|--------|
| LCP (app load) | under 2s |
| Frame time | under 16ms (60fps) |
| Jank (scrolling) | 0 |
| Startup time (cold) | under 2s |
| Memory usage | under 200MB |

## Bundle Budget

| App Type | Budget |
|----------|--------|
| Hello World | under 10MB |
| Typical app | under 20MB |
| Feature-rich app | under 50MB |

## Image Optimization

- Always specify width/height for images
- Use cached_network_image for network images
- Use proper image formats (WebP for web, PNG for icons)

## Animation Performance

Animate only compositor-friendly properties: opacity and transform.

## Use Performance Tools

```bash
# Profile app
flutter run --profile

# Run with tracing
flutter run --trace-startup

# Check render performance
flutter doctor -v
```

## Performance Checklist

- [ ] Images have explicit dimensions
- [ ] ListView uses itemBuilder (not children)
- [ ] Const constructors for static widgets
- [ ] No unnecessary setState calls
- [ ] Animations use transform/opacity only
- [ ] Network images use caching
- [ ] Hot reload works without corruption