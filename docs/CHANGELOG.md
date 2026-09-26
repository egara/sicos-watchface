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
- Implemented **GruvBoxEsk** aesthetic design:
  - Added open-source `DSEG7 Classic` and `DSEG14 Classic` LCD binary fonts to `res/font/`.
  - Configured authentic Gruvbox Material Dark palette (`#282828` background, `#d4be98` active digits, `#ea6962` red heart, `#7daea3` aqua steps, `#a9b665` green battery).
  - Built inactive LCD segment underlay ("ghost" `88:88` digits and `~~~ ~~~ ~~` date matrix) using `PartText` and `#3c3836` for authentic retro LCD display.
  - Replaced linear top battery metric with an outer circular 10-segment battery gauge (`<Arc>` with `dashIntervals="123.09 12"`), showing an inactive ghost ring in `#3c3836` and proportional fill in Gruvbox green `#ffa9b665`.
  - Reorganized top metrics into 2 spacious, centered columns for Heart Rate and Step Count.
  - Successfully verified live rendering on device with ADB screen capture at both 100% and simulated 25% battery levels.




