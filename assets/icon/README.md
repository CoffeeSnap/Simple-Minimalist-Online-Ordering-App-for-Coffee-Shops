# Pierre's Cafe App Icon

## Quick Start

### 1. Convert SVG to PNG (1024x1024)

If you have the SVG design, convert it to a high-resolution PNG:

```bash
cd assets/icon

# Using ImageMagick
convert icon_design.svg -resize 1024x1024 icon-1024.png

# OR using rsvg-convert (better quality)
rsvg-convert -w 1024 -h 1024 icon_design.svg > icon-1024.png

# OR use an online converter
# Upload icon_design.svg to https://cloudconvert.com/svg-to-png
```

### 2. Generate All Sizes

Run the generation script:

```bash
cd assets/icon
./generate_icons.sh
```

This will create:
- `store/` - Store listing icons
- `ios/` - All iOS app icons
- `android/` - All Android app icons

### 3. Install Icons in Project

#### For iOS:

```bash
# Copy generated icons to Xcode asset catalog
cp -r ios/* ../../ios/Runner/Assets.xcassets/AppIcon.appiconset/
```

Or manually in Xcode:
1. Open `ios/Runner.xcworkspace`
2. Navigate to `Runner > Assets.xcassets > AppIcon`
3. Drag and drop icon files from `assets/icon/ios/`

#### For Android:

```bash
# Copy to Android resources
cp -r android/mipmap-*/* ../../android/app/src/main/res/
```

### 4. Upload to Stores

When submitting your app:

- **App Store**: Upload `store/ios-store-icon-1024.png`
- **Play Store**: Upload `store/android-store-icon-512.png`

---

## Design Files

- `icon_design.svg` - Master icon design (editable vector)
- `icon-1024.png` - Source file for generation (create this first)

---

## Installation Requirements

### macOS:
```bash
brew install imagemagick
# Optional for better SVG support:
brew install librsvg
```

### Ubuntu/Debian:
```bash
sudo apt-get install imagemagick librsvg2-bin
```

---

## Alternative Methods

### Method 1: Use Flutter Launcher Icons Package

Add to `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon/icon-1024.png"
  adaptive_icon_background: "#D4A574"
  adaptive_icon_foreground: "assets/icon/icon-1024.png"
  remove_alpha_ios: true
```

Then run:
```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

### Method 2: Online Tools

Upload `icon-1024.png` to:
- [appicon.co](https://appicon.co/)
- [makeappicon.com](https://makeappicon.com/)
- [icon.kitchen](https://icon.kitchen/)

Download and extract to project.

---

## Icon Design Specifications

### Colors Used
- Background: `#D4A574` (Light Brown)
- Cup: `#FFF8DC` (Pale Yellow)
- Accent: `#8BA888` (Coffee Green)
- Outline: `#8B6F47` (Dark Brown)
- Steam: `#FFFAF0` (Cream)

### Design Elements
- ☕ Coffee cup with steam
- Circular green background accent
- "PIERRE'S" text at bottom
- Subtle "P" monogram overlay

### Guidelines
- Simple and recognizable at small sizes
- No gradients that don't scale well
- High contrast for visibility
- Rounded corners applied by iOS automatically
- Android adaptive icon safe zone: center 66%

---

## Testing Icons

### On iOS:
```bash
flutter run -d "iPhone 15 Pro"
# Check home screen, settings, spotlight
```

### On Android:
```bash
flutter run -d emulator-5554
# Long-press home screen to see adaptive icon shapes
```

### Preview Tools:
- [iOS Icon Preview](https://www.iosicongallery.com/preview)
- Android Studio > Resource Manager > Preview

---

## Troubleshooting

### "ImageMagick not found"
Install ImageMagick:
```bash
brew install imagemagick  # macOS
```

### "Icons not showing in app"
- Clean and rebuild: `flutter clean && flutter pub get`
- For iOS: Delete and reinstall app
- For Android: Uninstall app completely

### "SVG conversion looks blurry"
Use `librsvg` instead:
```bash
brew install librsvg
rsvg-convert -w 1024 -h 1024 icon_design.svg > icon-1024.png
```

### "Android adaptive icons clipped"
Ensure important content is in the center 66% of the icon (safe zone).

---

## File Count

✅ **iOS**: 14 files
✅ **Android**: 18 files
✅ **Store**: 2 files

**Total**: 34 icon files generated

---

## Support

For detailed size requirements, see `ICON_REQUIREMENTS.md`
