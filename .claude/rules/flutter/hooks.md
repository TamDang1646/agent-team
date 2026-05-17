> This file extends [common/hooks.md](../../common/hooks.md) with Flutter-specific hooks.

# Flutter Hooks

## PostToolUse Hooks

### Format on Save

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "flutter format \"$FILE_PATH\"",
        "description": "Format Flutter files with flutter format"
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
        "command": "flutter analyze \"$FILE_PATH\"",
        "description": "Analyze Flutter files for issues"
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
        "description": "Block Flutter writes that exceed 800 lines"
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
      },
      {
        "command": "flutter test",
        "description": "Run test suite"
      }
    ]
  }
}
```

## Ordering

Recommended order:
1. flutter format
2. flutter analyze
3. flutter test
4. build verification