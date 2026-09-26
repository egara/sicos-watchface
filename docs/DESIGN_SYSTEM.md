# Design System & Specifications

## 1. Canvas & Geometry
* **Form Factor**: Circular
* **Base Dimension**: 450 x 450 px
* **Clip Shape**: `CIRCLE`

## 2. Color Palette (Gruvbox Material Dark)
* **Background (`#ff282828`)**: Gruvbox dark surface tone.
* **Inactive Segments / Ghost LCD (`#ff32302f`)**: Low-contrast background digits (`88:88`).
* **Active Digits & Line (`#ffd4be98`)**: Gruvbox Cream / Light Yellow.
* **Heart Rate Accent (`#ffea6962`)**: Gruvbox Red.
* **Cardio Load Accent (`#ffea6962`)**: Gruvbox Red.
* **Step Count Accent (`#ff83a598`)**: Gruvbox Bright Blue.
* **Temperature Accent (`#ffd8a657`)**: Gruvbox Yellow.
* **Battery Accent (`#ffa9b665`)**: Gruvbox Green.

## 3. Typography
* **Digital Clock (7-Segment LCD)**: `DSEG7 Classic Bold` (`res/font/dseg7_classic_bold.ttf`).
* **Metric Numbers (7-Segment LCD)**: `DSEG7 Classic Bold` (`res/font/dseg7_classic_bold.ttf`).
* **Date (14-Segment LCD)**: `DSEG14 Classic Bold` (`res/font/dseg14_classic_bold.ttf`).

* **Outer Perimeter (R=215, Diameter=430px)**:
  - Circular 10-segment battery gauge with 12px gaps (`dashIntervals="123.09 12"` with `dashPhase="61.5"`).
  - Aligned with 12:00: the first segment begins exactly at the top vertical axis (12 o'clock / 0°), providing perfect vertical symmetry across the 12:00 and 6:00 axes.
  - Background track: Inactive segments in Gruvbox dark gray (`#ff3c3836`).
  - Active fill: Dynamic arc filled proportionally up to 360° in Gruvbox green (`#ffa9b665`). (e.g. 25% fills exactly 2.5 segments).
* **Top Row (y=55 to 145)**: 3 universal and customizable complication columns (`ComplicationSlot`, `SHORT_TEXT` / `RANGED_VALUE`):
  - **Slot 1 (Left, x=78, w=100)**: Customizable complication (defaults to Fitbit Cardio Load) in Gruvbox Red (`#ffea6962`). Renders dynamic provider icon (`[COMPLICATION.MONOCHROMATIC_IMAGE]`) with fallback to Fitbit official cardio heart vector (`ic_heart`).
  - **Slot 2 (Center, x=175, w=100)**: Customizable complication (defaults to Step Count) in Gruvbox Bright Blue (`#ff83a598`). Renders dynamic provider icon (`[COMPLICATION.MONOCHROMATIC_IMAGE]`) with fallback to official sneaker vector (`ic_steps`).
  - **Slot 3 (Right, x=272, w=100)**: Customizable complication (defaults to Weather Temperature) in Gruvbox Yellow (`#ffd8a657`). Renders dynamic weather condition icon (`[COMPLICATION.MONOCHROMATIC_IMAGE]`) with fallback to thermometer vector (`ic_temp`).
* **Center (y=168)**:
  - Underlay: Ghost `88:88` digits.
  - Overlay: Real-time digital clock (`hh:mm`).
* **Separator (y=295)**: Horizontal line with rounded caps (`#ffd4be98`).
* **Bottom (y=318)**: Formatted date: `[DAY_OF_WEEK_S] [MONTH_S] [DAY]` (e.g. `THU SEP 24`).

## 5. User Configurations (`<UserConfigurations>`)
* **`clean_gruvbox_icons` (Boolean, default: `TRUE`)**:
  - `TRUE`: Health metrics (Cardio Load & Steps) display authentic, clean Gruvbox vector icons (`ic_heart`, `ic_steps`) ensuring 100% exact Gruvbox Red (`#ea6962`) and Bright Blue (`#83a598`) colors without provider tint interference.
  - `FALSE`: Full dynamic complication icons (`[COMPLICATION.MONOCHROMATIC_IMAGE]`) delivered by any third-party provider.
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

