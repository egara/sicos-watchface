# Design System & Specifications

## 1. Canvas & Geometry
* **Form Factor**: Circular
* **Base Dimension**: 450 x 450 px
* **Clip Shape**: `CIRCLE`

## 2. Color Palettes (`theme_palette`)
The watch face supports three selectable color themes via `<ColorConfiguration id="theme_palette">`:

1. **Gruvbox Dark (`gruvbox`, default)**:
   - Surface Background: `#ff282828`
   - Inactive Segments / Ghost LCD / Battery Track: `#ff3c3836`
   - Active Digits, Text & Separator: `#ffd4be98`
   - Cardio Load Accent: `#ffea6962`
   - Steps Accent: `#ff83a598`
   - Temperature Accent: `#ffd8a657`
   - Battery Gauge Accent: `#ffa9b665`

2. **Tokyo Night (`tokyo_night`)**:
   - Surface Background: `#ff1a1b26`
   - Inactive Segments / Ghost LCD / Battery Track: `#ff24283b`
   - Active Digits, Text & Separator: `#ffc0caf5`
   - Cardio Load Accent: `#fff7768e`
   - Steps Accent: `#ff7aa2f7`
   - Temperature Accent: `#ffe0af68`
   - Battery Gauge Accent: `#ff9ece6a`

3. **Catppuccin Mocha (`catppuccin_mocha`)**:
   - Surface Background: `#ff1e1e2e`
   - Inactive Segments / Ghost LCD / Battery Track: `#ff313244`
   - Active Digits, Text & Separator: `#ffcdd6f4`
   - Cardio Load Accent: `#fff38ba8`
   - Steps Accent: `#ff89b4fa`
   - Temperature Accent: `#fff9e2af`
   - Battery Gauge Accent: `#ffa6e3a1`

## 3. Typography
* **Digital Clock (7-Segment LCD)**: `DSEG7 Classic Bold` (`res/font/dseg7_classic_bold.ttf`).
* **Metric Numbers (7-Segment LCD)**: `DSEG7 Classic Bold` (`res/font/dseg7_classic_bold.ttf`).
* **Date (14-Segment LCD)**: `DSEG14 Classic Bold` (`res/font/dseg14_classic_bold.ttf`).

* **Outer Perimeter (R=215, Diameter=430px)**:
  - Circular 10-segment battery gauge with discrete 32.8° arc segments and 3.2° gaps.
  - Aligned with 12:00: bilateral symmetry with gaps centered at 12:00 (0°) and 6:00 (180°). Segment 1 spans 1.6° to 34.4°, Segment 10 spans 325.6° to 358.4°.
  - Background track: Inactive segments dynamically colored by `[CONFIGURATION.theme_palette.1]`.
  - Active fill: Illuminated segments colored by `[CONFIGURATION.theme_palette.6]`. Completely filled for completed 10% blocks, and continuously progressing within the current active segment (e.g. at 86%, segments 1–8 are 100% full, segment 9 is 60% filled, and segment 10 is inactive).
* **Top Row (y=55 to 145)**: 3 universal and customizable complication columns (`ComplicationSlot`, `SHORT_TEXT` / `RANGED_VALUE`):
  - **Slot 1 (Left, x=78, w=100)**: Customizable complication (defaults to Fitbit Cardio Load) in theme accent color 3 (`[CONFIGURATION.theme_palette.3]`). Renders dynamic provider icon or custom vector (`ic_heart`).
  - **Slot 2 (Center, x=175, w=100)**: Customizable complication (defaults to Step Count) in theme accent color 4 (`[CONFIGURATION.theme_palette.4]`). Renders dynamic provider icon or custom vector (`ic_steps`).
  - **Slot 3 (Right, x=272, w=100)**: Customizable complication (defaults to Weather Temperature) in theme accent color 5 (`[CONFIGURATION.theme_palette.5]`). Renders dynamic weather condition icon with fallback to thermometer vector (`ic_temp`).
* **Center (y=168)**:
  - Underlay: Ghost `88:88` digits in `[CONFIGURATION.theme_palette.1]`.
  - Overlay: Real-time digital clock (`hh:mm`) in `[CONFIGURATION.theme_palette.2]`.
* **Separator (y=295)**: Horizontal line with rounded caps in `[CONFIGURATION.theme_palette.2]`.
* **Bottom (y=318)**: Formatted date: `[DAY_OF_WEEK_S] [MONTH_S] [DAY]` (e.g. `THU SEP 24`) in `[CONFIGURATION.theme_palette.2]` with underlay in `[CONFIGURATION.theme_palette.1]`.

## 5. User Configurations (`<UserConfigurations>`)
* **`theme_palette` (ColorConfiguration, default: `gruvbox`)**:
  - Lets the user pick between **Gruvbox Dark**, **Tokyo Night**, and **Catppuccin Mocha**. Dynamically updates backgrounds, active text, ghost LCD segments, complications, and battery gauge.
* **`native_icons` (Boolean, default: `FALSE`)**:
  - `TRUE`: Uses the dynamic/monochromatic icons provided natively by Fitbit or third-party providers (`[COMPLICATION.MONOCHROMATIC_IMAGE]`), tinted to the slot color.
  - `FALSE` (default): Uses the custom pixel-perfect vector icons designed specifically for this watch face (`ic_heart`, `ic_steps`, `ic_temp`), tinted to the active theme palette.
* **`time_format_24h` (Boolean, default: `TRUE`)**:
  - `TRUE`: 24-hour military digital clock format (`hh:mm` 00–23).
  - `FALSE`: 12-hour digital clock format (`hh:mm` 01–12).
* **`display_profile` (ListConfiguration, default: `full`)**:
  - `full` ("Full Display"): Complete watch face layout including outer 10-segment circular battery gauge, 3 top complication columns, digital clock, separator line, and bottom date with ghost underlay.
  - `time_only` ("Time Only (Clean)"): Minimalist, clean interactive layout displaying exclusively the central digital clock and inactive LCD "ghost" `88:88` digits (hiding battery meter, complications, separator, and date).

## 6. Interactive Tap Actions (`<Launch>`)
* **Time Area Tap (Clock)**: Launches system **Flashlight** (`com.google.android.clockwork.flashlight/.FlashlightActivity`).
* **Date Area Tap (Calendar)**: Launches system **Calendar** shortcut (`CALENDAR`).

## 7. Ambient Mode (Always-On Display - AOD)
* **Background**: Strict pure black (`#ff000000`) for maximum OLED power efficiency and burn-in prevention.
* **Preserved Elements**:
  - Center active digital time (`hh:mm`) in high-contrast Gruvbox cream (`#ffd4be98`).
  - Inactive LCD "ghost" segments (`88:88`) in dark gray (`#ff3c3836`).
* **Hidden Elements (`alpha=0`)**:
  - Outer 10-segment circular battery gauge.
  - Top 3 complication slots (Cardio Load, Steps, Temperature).
  - Horizontal separator line.
  - Bottom alphanumeric date row (both active text and ghost matrix).

