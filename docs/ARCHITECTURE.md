# Architecture & Project Structure

## 1. Overview
The watch face is developed targeting Wear OS (Wear OS 5 on Google Pixel Watch 3) using the **Watch Face Format (WFF)**. In WFF, the watch face layout, complications, expressions, and styling are entirely declared via XML.

## 2. Directory Layout (Standard WFF Application)

```
.
├── .agents/
│   └── skills/
│       └── watchface-dev/
│           └── SKILL.md       # Development skill definition
├── docs/                      # Project documentation
│   ├── ARCHITECTURE.md
│   ├── CHANGELOG.md
│   ├── DESIGN_SYSTEM.md
│   ├── ENVIRONMENT.md
│   └── README.md
├── shell.nix                  # NixOS environment definition
├── build.gradle.kts           # Root gradle configuration
├── settings.gradle.kts        # Project settings
└── app/
    ├── build.gradle.kts       # Android Wear module build file
    └── src/
        └── main/
            ├── AndroidManifest.xml
            └── res/
                ├── raw/
                │   └── watchface.xml   # Core Watch Face Format definition
                ├── drawable/           # Visual assets (backgrounds, vectors)
                └── values/
                    └── strings.xml
```

## 3. Specifications & Standards
* **Format**: Watch Face Format (WFF) v1/v2
* **Target Device**: Google Pixel Watch 3 (Wear OS 5, API level 34)
* **Screen Resolution**: Circular display, typically 450x450 (or 456x456)
* **Clock Type**: To be configured (Analog / Digital)
