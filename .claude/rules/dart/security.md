> This file extends [common/security.md](../../common/security.md) with Dart-specific content.

# Dart Security

## Secret Management

- NEVER hardcode API keys in Dart code
- ALWAYS use `flutter_dotenv` or `flutter_config`
- Use `--dart-define` for build-time secrets

## Platform Channels

Validate data crossing platform boundaries.

## HTTPS and Network

Always use HTTPS and certificate pinning for sensitive APIs.

## Input Validation

Validate all user inputs before processing.

## Secure Storage

Use `flutter_secure_storage` for sensitive data.

## Security Checklist

- [ ] No hardcoded secrets in source code
- [ ] API keys loaded from environment or --dart-define
- [ ] HTTPS used for all network calls
- [ ] Certificate pinning for sensitive endpoints
- [ ] User inputs validated before processing
- [ ] Secure storage used for tokens/passwords
- [ ] Platform channel data validated