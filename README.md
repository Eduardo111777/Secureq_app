# SecureQ: Quantum Password Generator

SecureQ is a futuristic hybrid quantum-classical password generator app built with Flutter. It simulates the BB84 quantum key distribution protocol to generate ultra-secure, entropy-rich passwords. The application features a visually engaging interface, modern design, and is optimized for Android devices.

---

## 🧠 Key Features

- 🔐 **Quantum-Inspired Security**: Uses simulated BB84 logic for generating shared secret keys.
- ✨ **Modern Visuals**: Futuristic white-gold-dark theme with customizable visual chips.
- 💡 **Password Options**: Generate passwords of 16, 24, 32, or 40 characters.
- 📲 **Cross-Platform Ready**: Built with Flutter, but currently targeting **Android (Google Play)**.
- 📋 **Clipboard Copying** and Real-Time Password Visibility Toggle.

---

## 📦 Project Structure

```bash
/lib
  /screens                # Main screens (Welcome, Generator)
  /widgets                # Custom shared widgets
  /theme                  # Centralized theme configuration
  main.dart               # App entry point
/android
  build.gradle.kts        # Android build config (release-ready)
key.properties            # 🔒 Keystore config (excluded from repo)
/assets                   # Optional custom icons or logos
