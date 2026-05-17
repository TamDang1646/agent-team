> This file extends [common/hooks.md](../../common/hooks.md) with Dart-specific hooks.

# Dart Hooks

## PostToolUse Hooks

### Format on Save

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "dart format \"$FILE_PATH\"",
        "description": "Format Dart files with dart format"
      }
    ]
  }
}
```

### Lint Check

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "dart analyze \"$FILE_PATH\"",
        "description": "Analyze Dart files for issues"
      }
    ]
  }
}
```

## PreToolUse Hooks

### Guard File Size

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write",
        "command": "wc -l \"$FILE_PATH\" | awk '{if($1>800) {print \"[Hook] BLOCKED: File exceeds 800 lines\"; exit 2}}'",
        "description": "Block Dart writes that exceed 800 lines"
      }
    ]
  }
}
```

## Stop Hooks

### Final Build Verification

```json
{
  "hooks": {
    "Stop": [
      {
        "command": "flutter build apk --debug",
        "description": "Verify debug build compiles"
      }
    ]
  }
}
```

## Ordering

Recommended order:
1. dart format
2. dart analyze
3. build verification