# NixOS Environment & Deployment Guide

## 1. Reproducible Shell with Nix

This project relies on an isolated development shell defined in `shell.nix`. No packages need to be installed imperatively on the host NixOS system.

To enter the environment:
```bash
nix-shell
```

Inside this shell, the following tools are available:
* Java Development Kit (JDK 17)
* Android SDK (API 34 / Wear OS 5 platform, platform-tools, build-tools)
* `adb` (Android Debug Bridge)
* Gradle

## 2. Deploying to Pixel Watch 3 via Wi-Fi ADB

1. **Enable Developer Options on the Watch**:
   - Go to **Settings** -> **System** -> **About** -> **Versions**.
   - Tap **Build number** 7 times until you see the message "You are now a developer!".

2. **Enable Wireless Debugging**:
   - Go to **Settings** -> **Developer options**.
   - Enable **ADB debugging**.
   - Enable **Wireless debugging**.
   - Ensure the watch and your development computer are on the same Wi-Fi network.

3. **Pair the Device**:
   - In **Wireless debugging**, select **Pair new device**.
   - Note the IP address, Port, and 6-digit Wi-Fi pairing code.
   - Run from `nix-shell`:
     ```bash
     adb pair <WATCH_IP>:<PAIRING_PORT> <PAIRING_CODE>
     ```

4. **Connect to the Watch**:
   - Go back to the main Wireless debugging screen to note the connection port (which can differ from the pairing port).
   - Run:
     ```bash
     adb connect <WATCH_IP>:<CONNECTION_PORT>
     adb devices
     ```

5. **Build and Install**:
   ```bash
   ./gradlew installDebug
   ```
