# Changelog

All notable changes and milestones for the **sicos-watchface** project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]
### Fixed
- Fixed circular battery gauge progression inaccuracy:
  - Replaced continuous arc with `dashIntervals`/`dashPhase` with 10 discrete `<Arc>` segments.
  - Eliminated phase distortion caused by clipping dynamic `endAngle` over dashed strokes.
  - Symmetrically aligned segments with gaps centered at 12:00 (0°) and 6:00 (180°).
  - Added continuous proportional progression within each segment via dynamic `<Transform target="endAngle">` (e.g. at 86%, segments 1–8 are 100% full, segment 9 is 60% filled, and segment 10 is inactive).
  - Verified live on Google Pixel Watch 3 with ADB screen captures.

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
- Replaced static top metrics with 3 customizable `ComplicationSlot` elements:
  - **Slot 1 (Left)**: Fitbit Cardio Load (`OffloadableCardioLoadComplicationDataSourceService`) in Gruvbox Red (`#ffea6962`) using `ic_heart`.
  - **Slot 2 (Center)**: Step Count (`STEP_COUNT`) in Gruvbox Aqua (`#ff7daea3`) using `ic_steps`.
  - **Slot 3 (Right)**: Weather Temperature (`CWComplicationService`) in Gruvbox Yellow (`#ffd8a657`) with dynamic weather condition icon (`[COMPLICATION.MONOCHROMATIC_IMAGE]`) tinted to match the Gruvbox palette, and fallback to `ic_temp`.
- Made all 3 complication slots fully dynamic and universal:
  - Configured conditional rendering (`[COMPLICATION.MONOCHROMATIC_IMAGE] != null`) across Slot 1, Slot 2, and Slot 3.
  - When the user selects any third-party or system provider, its native icon is automatically rendered and tinted to that column's Gruvbox accent color (Red, Bright Blue, Yellow).
  - Clean internal vector drawables (`ic_heart`, `ic_steps`, `ic_temp`) serve as reliable fallbacks whenever a provider does not supply an icon.
  - Fully verified and deployed to Google Pixel Watch 3 via ADB.
- Added native `<UserConfigurations>` settings for personalization:
  - Added `clean_gruvbox_icons` boolean configuration ("Gruvbox Native Icons"): allows users to choose between pixel-perfect Gruvbox native icons (with exact RGB color fidelity) and dynamic third-party provider icons.
  - Added `time_format_24h` boolean configuration ("24-Hour Time Format"): toggles between 24-hour military time (`hourFormat="24"`) and 12-hour standard time (`hourFormat="12"`).
  - Converted internal icon resources to 48x48 raster PNGs in `res/drawable-nodpi/` to guarantee native rendering in the pure Watch Face Format runtime (`DeclarativeWatchFaceRuntimePrebuilt`).
  - Added user-facing English strings and descriptions in `res/values/strings.xml`.
  - Updated design documentation in `docs/DESIGN_SYSTEM.md` and verified live rendering on Google Pixel Watch 3.
- Added interactive tap shortcuts (`<Launch>`):
  - Digital clock area triggers system **Flashlight** (`com.google.android.clockwork.flashlight/.FlashlightActivity`).
  - Bottom date area triggers system **Calendar** shortcut (`CALENDAR`).
- Implemented strict minimalist Always-On Display (AOD / Ambient Mode):
  - Switched ambient scene background to pure black (`#ff000000`) for maximum OLED energy efficiency.
  - Automatically hides (`alpha=0`) outer circular battery gauge, all 3 top complications, separator line, and bottom date row.
  - Preserves only the central digital clock (`hh:mm`) and the retro inactive LCD "ghost" segments (`88:88`).
- Added `display_profile` user configuration option:
  - Supports switching between **Full Display** (`full`, default) and **Time Only / Clean** (`time_only`).
  - In `time_only` mode, conditionally hides outer circular battery gauge, all 3 top complication slots, horizontal separator line, and bottom date row while maintaining the central digital clock and LCD ghost segments.
  - Added localized strings in `res/values/strings.xml` and updated design documentation.
- Aligned outer 10-segment circular battery gauge with 12:00:
  - Adjusted `dashPhase="61.5"` on the stroke pattern so that the first segment starts cleanly aligned with the 12 o'clock vertical mark (0°).
  - Achieved vertical bilateral symmetry with gaps aligned at 12:00 (0°) and 6:00 (180°).
- Fixed regression where complication icons disappeared under nested conditions:
  - Flattened nested `<Condition>` blocks inside all three `<ComplicationSlot>` elements into single-level expressions with boolean logic (`&&` / `||`), fully restoring Gruvbox native icons and dynamic icons.


