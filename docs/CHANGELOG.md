# Changelog

All notable changes and milestones for the **sicos-watchface** project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]
### Added
- Project development skill defined at `.agents/skills/watchface-dev/SKILL.md`.
- Documentation structure established under `docs/` (`ARCHITECTURE.md`, `DESIGN_SYSTEM.md`, `ENVIRONMENT.md`, `CHANGELOG.md`).
- Fully isolated NixOS development shell in `shell.nix` with Android SDK (API 34), JDK 17, and platform-tools.
- Pure Watch Face Format baseline project structure (Gradle 8.9 + AGP 8.5.2).
- Minimal valid WFF `watchface.xml` displaying digital time (hours, minutes, and ambient-reactive seconds).
- Verified initial compilation with `./gradlew assembleDebug` (outputs `app-debug.apk`).
- Successfully paired, connected via Wi-Fi ADB, and deployed `app-debug.apk` to the Pixel Watch 3 (`com.sicos.watchface.debug`).
