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
* **Step Count Accent (`#ff7daea3`)**: Gruvbox Aqua/Blue.
* **Battery Accent (`#ffa9b665`)**: Gruvbox Green.

## 3. Typography
* **Digital Clock (7-Segment LCD)**: `DSEG7 Classic Bold` (`res/font/dseg7_classic_bold.ttf`).
* **Metric Numbers (7-Segment LCD)**: `DSEG7 Classic Bold` (`res/font/dseg7_classic_bold.ttf`).
* **Date (14-Segment LCD)**: `DSEG14 Classic Bold` (`res/font/dseg14_classic_bold.ttf`).

## 4. Layout & Layers
* **Top Row (y=65 to 155)**: 3 columns with custom vector icons and real-time sensor metrics:
  - Heart Rate (`[HEART_RATE]`)
  - Step Count (`[STEP_COUNT]`)
  - Battery Percentage (`[BATTERY_PERCENT]%`)
* **Center (y=168)**:
  - Underlay: Ghost `88:88` digits.
  - Overlay: Real-time digital clock (`hh:mm`).
* **Separator (y=295)**: Horizontal line with rounded caps (`#ffd4be98`).
* **Bottom (y=318)**: Formatted date: `[DAY_OF_WEEK_S] [MONTH_S] [DAY]` (e.g. `THU SEP 24`).

## 5. Ambient Mode (Always-On Display - AOD)
* Top metrics row fades out (`alpha=0`) to save battery and prevent burn-in.
* Digital clock and date remain visible in high-contrast Gruvbox cream.

