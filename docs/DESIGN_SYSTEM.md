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

* **Outer Perimeter (R=215, Diameter=430px)**:
  - Circular 10-segment battery gauge with 12px gaps (`dashIntervals="123.09 12"`).
  - Background track: Inactive segments in Gruvbox dark gray (`#ff3c3836`).
  - Active fill: Dynamic arc filled proportionally up to 360° in Gruvbox green (`#ffa9b665`). (e.g. 25% fills exactly 2.5 segments).
* **Top Row (y=55 to 145)**: 2 centered columns with custom pixel-art icons and metrics:
  - Heart Rate (`[HEART_RATE]`) in Gruvbox Red (`#ffea6962`).
  - Step Count (`[STEP_COUNT]`) in Gruvbox Aqua (`#ff7daea3`).
* **Center (y=168)**:
  - Underlay: Ghost `88:88` digits.
  - Overlay: Real-time digital clock (`hh:mm`).
* **Separator (y=295)**: Horizontal line with rounded caps (`#ffd4be98`).
* **Bottom (y=318)**: Formatted date: `[DAY_OF_WEEK_S] [MONTH_S] [DAY]` (e.g. `THU SEP 24`).

## 5. Ambient Mode (Always-On Display - AOD)
* Top metrics row fades out (`alpha=0`) to save battery and prevent burn-in.
* Digital clock and date remain visible in high-contrast Gruvbox cream.

