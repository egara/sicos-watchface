---
name: watchface-dev
description: >-
  Expert guide and standards for developing, maintaining, and testing Wear OS Watch Faces
  using Watch Face Format (WFF) on NixOS. Activates when working on watch face projects,
  creating or editing watch face XML definitions, configuring build tools, or deploying to Wear OS devices.
---

# Watch Face Development Skill (Wear OS & NixOS)

This skill governs the development of Wear OS watch faces with primary focus on the **Watch Face Format (WFF)** standard on **NixOS**.

---

## 1. Core Principles & Rules

1. **Language Standard**:
   - All code, XML configurations, build files, code comments, commit messages, and source annotations MUST be written in **English**.
   - User interaction in chat can follow the user's language (e.g., Spanish), but deliverables and codebase artifacts remain in English.

2. **No Hallucinations / Strict Sourcing**:
   - Adhere strictly to the official Watch Face Format (WFF) specification.
   - Do NOT invent XML tags, attributes, expressions, or APIs.
   - Verified documentation sources:
     - **Official WFF Overview & Guide**: [https://developer.android.com/training/wearables/wff](https://developer.android.com/training/wearables/wff)
     - **WFF Setup & Project Structure**: [https://developer.android.com/training/wearables/wff/setup](https://developer.android.com/training/wearables/wff/setup)
     - **WFF XML Reference**: [https://developer.android.com/reference/wear-os/wff/watch-face](https://developer.android.com/reference/wear-os/wff/watch-face) and [https://developer.android.com/training/wearables/wff/api-reference](https://developer.android.com/training/wearables/wff/api-reference)
     - **Official Samples Repository**: [https://github.com/android/wear-os-samples/tree/main/WatchFaceFormat](https://github.com/android/wear-os-samples/tree/main/WatchFaceFormat)
     - **Samsung Watch Face Studio Reference**: [https://developer.samsung.com/watch-face-studio/user-guide/index.html](https://developer.samsung.com/watch-face-studio/user-guide/index.html)
     - **WFF XML Schema (XSD) & Validation**: [https://github.com/google/watchface](https://github.com/google/watchface)

3. **Isolated NixOS Environment**:
   - The host system runs **NixOS**.
   - Do NOT attempt to install packages directly into the host OS or mutate global paths.
   - All tooling (JDK, Android SDK/commandline-tools, `adb`, Gradle, etc.) must be defined declaratively in `shell.nix` (or `flake.nix`).
   - Every development/build session must run within `nix-shell` so that the environment is completely reproducible across machines.

---

## 2. Watch Face Format (WFF) Fundamentals

A pure WFF project does not compile custom Java/Kotlin rendering code. It is packaged as an Android Wear OS app with:
* An `AndroidManifest.xml` declaring the watch face service (`androidx.wear.watchface.editor.action.WATCH_FACE_EDITOR` / `com.google.android.wearable.watchface.category.WATCH_FACE`).
* A `res/raw/watchface.xml` (or `res/xml/watch_face.xml`) containing declarative XML describing visual layers, geometry, complications, and expressions.
* Required metadata declaring the WFF version (e.g., version 1 or 2 for Wear OS 4 / 5).
* Resource directories (`res/drawable`, etc.) for vector or raster assets.

### High-level WFF XML Structure:
```xml
<WatchFace width="450" height="450" clipShape="CIRCLE">
    <Metadata key="CLOCK_TYPE" value="ANALOG" /> <!-- or DIGITAL -->
    <Metadata key="PREVIEW_TIME" value="10:09:30" />

    <!-- User configurable styles (colors, complication slot styles) -->
    <UserConfigurations>
        ...
    </UserConfigurations>

    <!-- Visual hierarchy -->
    <Scene backgroundColor="#ff000000">
        <!-- Static background, markings, hands, or digital clocks -->
        ...
    </Scene>
</WatchFace>
```

---

## 3. Project Documentation Standard (`docs/`)

To ensure continuity across development sessions, LLM agent switches, and human inspection, all decisions and architecture must be continuously recorded.

The documentation is organized under the `docs/` directory:

```
docs/
├── ARCHITECTURE.md     # Project structure, WFF version, layers, and configuration layout.
├── CHANGELOG.md        # Iteration history, new features, bugfixes, and date-stamped logs.
├── DESIGN_SYSTEM.md    # Color palettes, typography, complication slot coordinates, AOD behavior.
└── ENVIRONMENT.md      # Nix shell setup, ADB over Wi-Fi pairing instructions for Pixel Watch.
```

### Documentation Workflow:
* Whenever a new component, slot, or configuration is added to the watch face XML, update `ARCHITECTURE.md` and `DESIGN_SYSTEM.md`.
* Whenever a milestone or debugging step is completed, record an entry in `CHANGELOG.md`.
* Keep instructions self-contained so that any future LLM can read `docs/` and understand the exact state of the project without context loss.

---

## 4. Nix Shell Specification (`shell.nix`)

The project environment must provide:
* **JDK** (OpenJDK 17 or compatible version recommended for modern Android Gradle builds).
* **Android Tools**: `android-tools` (`adb`, `fastboot`).
* **Android SDK**: `cmdline-tools`, `build-tools`, `platforms` for Wear OS (API 34/Wear OS 5).
* Build tool: `gradle`.

Example minimum `shell.nix` baseline:
```nix
{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    cmdlineToolsVersion = "8.0";
    toolsVersion = "26.1.1";
    platformToolsVersion = "35.0.1";
    buildToolsVersions = [ "34.0.0" ];
    includeEmulator = false;
    platformVersions = [ "34" ]; # Wear OS 5
    includeSources = false;
    includeSystemImages = false;
    useGoogleAPIs = false;
    useGoogleTVAddOns = false;
    includeNDK = false;
  };
  androidSdk = androidComposition.androidsdk;
in
pkgs.mkShell {
  name = "sicos-watchface-env";
  buildInputs = [
    androidSdk
    pkgs.jdk17
    pkgs.gradle
    pkgs.android-tools
  ];

  shellHook = ''
    export ANDROID_HOME="${androidSdk}/libexec/android-sdk"
    export ANDROID_SDK_ROOT="${androidSdk}/libexec/android-sdk"
    export PATH="$ANDROID_HOME/platform-tools:$PATH"
    echo "================================================="
    echo "  Sicos Watch Face Development Environment (Nix)"
    echo "  Android SDK: $ANDROID_HOME"
    echo "  Java: $(java -version 2>&1 | head -n 1)"
    echo "  ADB: $(which adb)"
    echo "================================================="
  '';
}
```

---

## 5. Deployment to Pixel Watch 3 via ADB

1. **Enable Developer Options on Pixel Watch 3**:
   - Settings -> System -> About -> Versions -> Tap "Build number" 7 times.
2. **Enable Wireless Debugging**:
   - Settings -> Developer options -> Enable "ADB debugging" and "Wireless debugging".
   - Under "Wireless debugging", select "Pair new device" to note IP, Port, and Pairing Code.
3. **From `nix-shell`**:
   ```bash
   adb pair <WATCH_IP>:<PAIR_PORT> <PAIRING_CODE>
   adb connect <WATCH_IP>:<CONNECT_PORT>
   adb devices
   ```
4. **Install & Run**:
   ```bash
   ./gradlew installDebug
   ```
