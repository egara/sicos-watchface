# Sicos Watch Face (Wear OS)

[![Wear OS](https://img.shields.io/badge/Wear%20OS-5%20(API%2034)-4285F4?logo=android&logoColor=white)](https://developer.android.com/training/wearables/wff)
[![Watch Face Format](https://img.shields.io/badge/Format-WFF%20v2-34A853)](https://developer.android.com/training/wearables/wff)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![NixOS Ready](https://img.shields.io/badge/NixOS-shell.nix-5277C3?logo=nixos&logoColor=white)](shell.nix)

A custom, retro-futuristic digital watch face for **Wear OS 5** (optimized for the **Google Pixel Watch 3**), designed with the authentic **Gruvbox Material Dark** color palette and classic segmented LCD aesthetics.

Built entirely using declarative XML with Google's official **Watch Face Format (WFF)** standard — completely native, lightweight, and zero background battery drain from custom runtimes.

---

## Features

- **Retro LCD Typography**:
  - Main digital time (`hh:mm`) rendered with 7-segment digital font (`DSEG7 Classic`).
  - Active time accompanied by realistic inactive LCD "ghost" segments (`88:88`) in a subtle dark underlay.
  - Date (`DAY_OF_WEEK MONTH DAY`) rendered with 14-segment alphanumeric font (`DSEG14 Classic`) over full inactive 14-bar matrix cells.
- **Gruvbox Material Dark Palette**:
  - Background: `#282828`
  - Inactive LCD ghost elements & gauge track: `#3c3836`
  - Active time & date: `#d4be98` (warm cream)
  - Cardio Load / Heart Rate accent: `#ea6962` (Gruvbox red)
  - Steps counter accent: `#83a598` (Gruvbox bright blue)
  - Weather / Temperature accent: `#d8a657` (Gruvbox yellow)
  - Battery gauge fill: `#a9b665` (Gruvbox green)
- **10-Segment Circular Outer Battery Gauge**:
  - Outer perimeter gauge (`R=215px`, diameter `430px`) styled with 10 discrete segments (`dashIntervals="123.09 12"`).
  - Subtle inactive track in `#3c3836` providing authentic hardware-meter feel.
  - Dynamically fills clockwise up to 360° based on actual battery percentage (`[BATTERY_PERCENT]`).
- **Dynamic & Customizable Complications (Top Row)**:
  - Three independent, centered complication columns (`ComplicationSlot` supporting `SHORT_TEXT`, `RANGED_VALUE`, and `EMPTY`):
    - **Slot 1 (Left)**: Defaults to Fitbit Cardio Load (`OffloadableCardioLoadComplicationDataSourceService`) in Gruvbox Red (`#ea6962`).
    - **Slot 2 (Center)**: Defaults to Steps Count (`STEP_COUNT`) in Gruvbox Bright Blue (`#83a598`).
    - **Slot 3 (Right)**: Defaults to Current Weather Temperature (`CWComplicationService`) in Gruvbox Yellow (`#d8a657`).
  - **Universal Fallback & Icon Support**: If any slot is replaced by the user with a custom complication provider, it dynamically renders the provider's monochromatic icon tinted to that slot's signature Gruvbox color.
- **User Configurations (`<UserConfigurations>`)**:
  - Customizable directly on the watch face customize screen or via the Pixel Watch smartphone companion app:
    - **Gruvbox Native Icons (`clean_gruvbox_icons`)**: When enabled (default), health metrics render crisp, bespoke Gruvbox icons (`ic_heart`, `ic_steps`, `ic_temp`) with 100% color fidelity, preventing provider tint distortion. When disabled, displays the provider's raw monochromatic icon.
    - **24-Hour Time Format (`time_format_24h`)**: Toggle between 24-hour military time (`hourFormat="24"`, default) and standard 12-hour time (`hourFormat="12"`).
    - **Display Profile (`display_profile`)**: Choose between **Full Display** (`full`, default) showing all metrics, battery ring, and date, or a clean **Time Only** (`time_only`) minimalist layout showing exclusively the digital clock and ghost LCD digits.
- **Interactive Tap Shortcuts (`<Launch>`)**:
  - **Digital Clock Tap**: Immediately launches the system **Flashlight** application (`com.google.android.clockwork.flashlight`).
  - **Date Matrix Tap**: Opens the system **Calendar / Agenda** app (`CALENDAR`).
- **Power Efficiency & Minimalist Always-On Display (AOD)**:
  - Strict true black background (`#000000`) for zero OLED power draw on inactive pixels.
  - Automatically hides all non-essential elements: outer circular battery gauge, all 3 complications, divider line, and bottom date row.
  - Preserves only the central digital clock (`hh:mm`) and the authentic inactive LCD ghost segments (`88:88`).

---

## Project Structure

```
├── .agents/
│   └── skills/
│       └── watchface-dev/     # LLM Agent development skill & WFF guidelines
├── app/
│   ├── src/main/
│   │   ├── AndroidManifest.xml # WFF Service & Wear OS Picker configuration
│   │   └── res/
│   │       ├── font/           # Binary TTF LCD fonts (DSEG7 & DSEG14)
│   │       ├── drawable-nodpi/ # Crisp pixel-art icons and preview assets
│   │       └── raw/
│   │           └── watchface.xml # Core Watch Face Format declarative layout
├── docs/                       # Comprehensive documentation
│   ├── ARCHITECTURE.md
│   ├── CHANGELOG.md
│   ├── DESIGN_SYSTEM.md
│   └── ENVIRONMENT.md
├── shell.nix                   # Reproducible NixOS development environment
├── build.gradle.kts
└── settings.gradle.kts
```

---

## Getting Started & Building

### Option 1: On NixOS (Recommended)

This repository includes a declarative `shell.nix` that provides OpenJDK 17, Android SDK (API 34), build-tools, platform-tools (`adb`), and Gradle without installing any global packages:

```bash
# Enter the isolated environment
nix-shell

# Inside the shell, build the debug APK
./gradlew assembleDebug
```

The compiled APK will be located at `app/build/outputs/apk/debug/app-debug.apk`.

### Option 2: Standard Android Environment

Requirements:
- **JDK 17**
- **Android SDK** with `platforms;android-34` and `build-tools;34.0.0`
- Environment variable `ANDROID_HOME` pointing to your Android SDK

```bash
./gradlew assembleDebug
```

---

## Installing to Pixel Watch via Wireless ADB (Sideloading)

Since this watch face is not yet published on Google Play, you can install and run it directly on your Pixel Watch using wireless debugging:

### 1. Enable Developer Options on your Watch
1. On your Pixel Watch, open **Settings**.
2. Tap **System** -> **About** -> **Versions**.
3. Tap **Build number** 7 times until you see the prompt *"You are now a developer!"*.

### 2. Enable Wireless Debugging
1. Go back to **Settings** -> **Developer options**.
2. Enable **ADB debugging**.
3. Scroll down and enable **Wireless debugging**.
4. Confirm that your watch and computer are connected to the **same Wi-Fi network**.

### 3. Pair the Watch with your Computer
1. In **Wireless debugging**, select **Pair new device**.
2. Note down the **IP address**, **Pairing Port**, and the **6-digit Wi-Fi pairing code**.
3. Run on your terminal (inside `nix-shell`):
   ```bash
   adb pair <WATCH_IP>:<PAIRING_PORT> <PAIRING_CODE>
   ```
   *(Example: `adb pair 192.168.1.50:44123 384834`)*

### 4. Connect to the Watch
1. Go back to the main **Wireless debugging** screen and check the **Port** listed under the IP address (this port is often different from the pairing port).
2. Connect to the device:
   ```bash
   adb connect <WATCH_IP>:<CONNECTION_PORT>
   ```
   *(Example: `adb connect 192.168.1.50:43479`)*
3. Verify connection:
   ```bash
   adb devices
   ```
   Your watch should appear in the list with status `device`.

### 5. Install and Activate the Watch Face
Build and install the APK directly to the connected watch:
```bash
./gradlew installDebug
```

Once installed, send a broadcast to notify the Wear OS picker to discover the new watch face:
```bash
adb shell am broadcast -a com.google.android.wearable.action.UPDATE_WATCH_FACES
```

Now, **long-press the watch screen**, scroll to the right, tap **+ (Add watch face)**, and select **Sicos Watch Face**.

---

## Updating & Iterating

When you make changes to [`app/src/main/res/raw/watchface.xml`](app/src/main/res/raw/watchface.xml):
```bash
./gradlew installDebug && adb shell am broadcast -a com.google.android.wearable.action.UPDATE_WATCH_FACES
```

To take an instant screenshot from your watch to verify layout:
```bash
adb exec-out screencap -p > watch_screen.png
```

---

## Documentation

Full architectural specifications, design guidelines, and changelogs are available under [`docs/`](docs/):
- [Architecture & Standards](docs/ARCHITECTURE.md)
- [Design System & Coordinates](docs/DESIGN_SYSTEM.md)
- [Changelog & Milestones](docs/CHANGELOG.md)
- [Environment Setup](docs/ENVIRONMENT.md)

---

## License

This project is licensed under the terms of the GNU General Public License v3.0 ([LICENSE](LICENSE)).
The embedded DSEG font family is licensed under the [SIL Open Font License 1.1](http://scripts.sil.org/OFL).
