---
name: dart-flutter-build-errors
description: Resolve Dart/Flutter build, analysis, and dependency errors
when_to_use: When `dart analyze`, `flutter analyze`, `flutter build`, or `pub get` fails
---

# Dart/Flutter Build Error Resolution

## Common Build Errors

### 1. Dependency Conflicts

```
Error: Cannot satisfy constraints on package:xyz
```

**Fix:**
```bash
# Update dependencies
flutter pub upgrade

# Clear cache and reinstall
flutter clean
rm pubspec.lock
flutter pub get
```

### 2. Null Safety Mismatch

```
Error: Package xyz does not support null safety
```

**Fix:**
```bash
# Upgrade package to null safety version
flutter pub upgrade --null-safety
```

### 3. Platform-Specific Build Errors

**iOS:**
```bash
cd ios
pod install
cd ..
flutter clean
flutter build ios
```

**Android:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter build apk
```

### 4. Dart Analyze Errors

```
error - Missing argument for parameter 'x'
warning - Dead code
hint - Unnecessary type annotation
```

**Common Fixes:**
- Fix function signatures to match calls
- Remove unreachable code after `return`/`throw`
- Remove redundant type annotations

### 5. Hot Reload Issues

```
Reloaded 0 of 0 libraries
```

**Fix:**
```bash
# Full restart
flutter run

# Or hot restart
flutter hot restart
```

### 6. Missing Platform Files

```
Target file "main.dart" not found
```

**Fix:**
```bash
flutter pub get
flutter run lib/main.dart
```

### 7. Gradle Build Errors (Android)

```
Could not resolve all files for configuration ':app:debugCompileClasspath'
```

**Fix:**
- Check `android/build.gradle` for correct repositories
- Update `compileSdkVersion` to latest stable
- Ensure `gradle-wrapper.properties` has compatible version

### 8. CocoaPods Errors (iOS)

```
Pod::DSLError: [!] Couldn't determine localizations
```

**Fix:**
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
```

## Analysis Command Reference

```bash
# Analyze all files
dart analyze

# Analyze specific file
dart analyze lib/path/to/file.dart

# Get more info
dart analyze --fatal-infos

# Fix lint issues automatically
dart fix --apply
```

## Build Command Reference

```bash
# Debug build
flutter build apk --debug
flutter build ios --debug

# Release build
flutter build apk --release
flutter build ios --release

# Web build
flutter build web

# Specific target
flutter build apk --target lib/main_android.dart
```

## Troubleshooting Flow

1. Run `flutter clean`
2. Delete `pubspec.lock`
3. Run `flutter pub get`
4. Run `flutter analyze`
5. Fix all errors
6. Run `flutter build`

## Common Error Patterns

| Error | Cause | Solution |
|-------|-------|----------|
| `MissingPluginException` | Plugin not registered | Run `flutter clean` then rebuild |
| `UnableToLockRequirements` | CocoaPods cache issue | `cd ios && pod install` |
| `Manifest merger failed` | Android manifest conflict | Check for duplicate permissions |
| `Conflicting dependencies` | Version mismatch | Update pubspec.yaml constraints |
| `Target kernel snapshot failed` | Build cache corruption | `flutter clean` |