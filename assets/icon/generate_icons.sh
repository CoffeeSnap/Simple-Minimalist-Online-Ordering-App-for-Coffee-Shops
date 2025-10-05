#!/bin/bash

# Icon Generation Script for Pierre's Cafe
# Requires ImageMagick: brew install imagemagick

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo -e "${RED}Error: ImageMagick is not installed${NC}"
    echo "Install it using: brew install imagemagick (macOS) or apt-get install imagemagick (Linux)"
    exit 1
fi

# Check if source icon exists
SOURCE_ICON="icon-1024.png"
if [ ! -f "$SOURCE_ICON" ]; then
    echo -e "${RED}Error: Source icon '$SOURCE_ICON' not found${NC}"
    echo "Please create a 1024x1024px PNG icon and name it 'icon-1024.png'"
    echo "You can convert the SVG to PNG using: convert icon_design.svg -resize 1024x1024 icon-1024.png"
    exit 1
fi

echo -e "${GREEN}Starting icon generation...${NC}\n"

# Create output directories
echo "Creating directories..."
mkdir -p ios
mkdir -p android/mipmap-ldpi
mkdir -p android/mipmap-mdpi
mkdir -p android/mipmap-hdpi
mkdir -p android/mipmap-xhdpi
mkdir -p android/mipmap-xxhdpi
mkdir -p android/mipmap-xxxhdpi
mkdir -p store

# ============================================
# STORE ICONS
# ============================================
echo -e "\n${YELLOW}Generating Store Icons...${NC}"

# iOS App Store (1024x1024)
echo "  - iOS Store Icon (1024x1024)"
convert "$SOURCE_ICON" -resize 1024x1024 -background none -flatten store/ios-store-icon-1024.png

# Android Play Store (512x512)
echo "  - Android Store Icon (512x512)"
convert "$SOURCE_ICON" -resize 512x512 store/android-store-icon-512.png

# ============================================
# iOS APP ICONS
# ============================================
echo -e "\n${YELLOW}Generating iOS App Icons...${NC}"

# iPhone Notification
echo "  - iPhone Notification Icons"
convert "$SOURCE_ICON" -resize 40x40 ios/Icon-20@2x.png
convert "$SOURCE_ICON" -resize 60x60 ios/Icon-20@3x.png

# iPhone Settings
echo "  - iPhone Settings Icons"
convert "$SOURCE_ICON" -resize 58x58 ios/Icon-29@2x.png
convert "$SOURCE_ICON" -resize 87x87 ios/Icon-29@3x.png

# iPhone Spotlight
echo "  - iPhone Spotlight Icons"
convert "$SOURCE_ICON" -resize 80x80 ios/Icon-40@2x.png
convert "$SOURCE_ICON" -resize 120x120 ios/Icon-40@3x.png

# iPhone App
echo "  - iPhone App Icons"
convert "$SOURCE_ICON" -resize 120x120 ios/Icon-60@2x.png
convert "$SOURCE_ICON" -resize 180x180 ios/Icon-60@3x.png

# iPad Notification
echo "  - iPad Notification Icons"
convert "$SOURCE_ICON" -resize 20x20 ios/Icon-20@1x.png

# iPad Settings
echo "  - iPad Settings Icons"
convert "$SOURCE_ICON" -resize 29x29 ios/Icon-29@1x.png

# iPad Spotlight
echo "  - iPad Spotlight Icons"
convert "$SOURCE_ICON" -resize 40x40 ios/Icon-40@1x.png

# iPad App
echo "  - iPad App Icons"
convert "$SOURCE_ICON" -resize 76x76 ios/Icon-76@1x.png
convert "$SOURCE_ICON" -resize 152x152 ios/Icon-76@2x.png

# iPad Pro
echo "  - iPad Pro Icon"
convert "$SOURCE_ICON" -resize 167x167 ios/Icon-83.5@2x.png

# iOS Store in bundle
echo "  - iOS Bundle Store Icon"
convert "$SOURCE_ICON" -resize 1024x1024 ios/Icon-1024.png

# ============================================
# ANDROID APP ICONS (Standard)
# ============================================
echo -e "\n${YELLOW}Generating Android App Icons (Standard)...${NC}"

convert "$SOURCE_ICON" -resize 36x36 android/mipmap-ldpi/ic_launcher.png
echo "  - ldpi (36x36)"

convert "$SOURCE_ICON" -resize 48x48 android/mipmap-mdpi/ic_launcher.png
echo "  - mdpi (48x48)"

convert "$SOURCE_ICON" -resize 72x72 android/mipmap-hdpi/ic_launcher.png
echo "  - hdpi (72x72)"

convert "$SOURCE_ICON" -resize 96x96 android/mipmap-xhdpi/ic_launcher.png
echo "  - xhdpi (96x96)"

convert "$SOURCE_ICON" -resize 144x144 android/mipmap-xxhdpi/ic_launcher.png
echo "  - xxhdpi (144x144)"

convert "$SOURCE_ICON" -resize 192x192 android/mipmap-xxxhdpi/ic_launcher.png
echo "  - xxxhdpi (192x192)"

# ============================================
# ANDROID ADAPTIVE ICONS
# ============================================
echo -e "\n${YELLOW}Generating Android Adaptive Icons...${NC}"
echo "Note: Using the full icon as foreground with transparent background"
echo "You may want to manually create a proper foreground/background split"

# Create a solid background color (light brown)
BACKGROUND_COLOR="#D4A574"

# Generate foreground layers (using the main icon)
convert "$SOURCE_ICON" -resize 36x36 android/mipmap-ldpi/ic_launcher_foreground.png
convert "$SOURCE_ICON" -resize 48x48 android/mipmap-mdpi/ic_launcher_foreground.png
convert "$SOURCE_ICON" -resize 72x72 android/mipmap-hdpi/ic_launcher_foreground.png
convert "$SOURCE_ICON" -resize 96x96 android/mipmap-xhdpi/ic_launcher_foreground.png
convert "$SOURCE_ICON" -resize 144x144 android/mipmap-xxhdpi/ic_launcher_foreground.png
convert "$SOURCE_ICON" -resize 192x192 android/mipmap-xxxhdpi/ic_launcher_foreground.png

# Generate background layers (solid color)
convert -size 36x36 xc:"$BACKGROUND_COLOR" android/mipmap-ldpi/ic_launcher_background.png
convert -size 48x48 xc:"$BACKGROUND_COLOR" android/mipmap-mdpi/ic_launcher_background.png
convert -size 72x72 xc:"$BACKGROUND_COLOR" android/mipmap-hdpi/ic_launcher_background.png
convert -size 96x96 xc:"$BACKGROUND_COLOR" android/mipmap-xhdpi/ic_launcher_background.png
convert -size 144x144 xc:"$BACKGROUND_COLOR" android/mipmap-xxhdpi/ic_launcher_background.png
convert -size 192x192 xc:"$BACKGROUND_COLOR" android/mipmap-xxxhdpi/ic_launcher_background.png

echo "  - All adaptive icon layers generated"

# ============================================
# GENERATE CONTENTS.JSON for iOS
# ============================================
echo -e "\n${YELLOW}Generating iOS Contents.json...${NC}"

cat > ios/Contents.json << 'EOF'
{
  "images" : [
    {
      "filename" : "Icon-20@2x.png",
      "idiom" : "iphone",
      "scale" : "2x",
      "size" : "20x20"
    },
    {
      "filename" : "Icon-20@3x.png",
      "idiom" : "iphone",
      "scale" : "3x",
      "size" : "20x20"
    },
    {
      "filename" : "Icon-29@2x.png",
      "idiom" : "iphone",
      "scale" : "2x",
      "size" : "29x29"
    },
    {
      "filename" : "Icon-29@3x.png",
      "idiom" : "iphone",
      "scale" : "3x",
      "size" : "29x29"
    },
    {
      "filename" : "Icon-40@2x.png",
      "idiom" : "iphone",
      "scale" : "2x",
      "size" : "40x40"
    },
    {
      "filename" : "Icon-40@3x.png",
      "idiom" : "iphone",
      "scale" : "3x",
      "size" : "40x40"
    },
    {
      "filename" : "Icon-60@2x.png",
      "idiom" : "iphone",
      "scale" : "2x",
      "size" : "60x60"
    },
    {
      "filename" : "Icon-60@3x.png",
      "idiom" : "iphone",
      "scale" : "3x",
      "size" : "60x60"
    },
    {
      "filename" : "Icon-20@1x.png",
      "idiom" : "ipad",
      "scale" : "1x",
      "size" : "20x20"
    },
    {
      "filename" : "Icon-20@2x.png",
      "idiom" : "ipad",
      "scale" : "2x",
      "size" : "20x20"
    },
    {
      "filename" : "Icon-29@1x.png",
      "idiom" : "ipad",
      "scale" : "1x",
      "size" : "29x29"
    },
    {
      "filename" : "Icon-29@2x.png",
      "idiom" : "ipad",
      "scale" : "2x",
      "size" : "29x29"
    },
    {
      "filename" : "Icon-40@1x.png",
      "idiom" : "ipad",
      "scale" : "1x",
      "size" : "40x40"
    },
    {
      "filename" : "Icon-40@2x.png",
      "idiom" : "ipad",
      "scale" : "2x",
      "size" : "40x40"
    },
    {
      "filename" : "Icon-76@1x.png",
      "idiom" : "ipad",
      "scale" : "1x",
      "size" : "76x76"
    },
    {
      "filename" : "Icon-76@2x.png",
      "idiom" : "ipad",
      "scale" : "2x",
      "size" : "76x76"
    },
    {
      "filename" : "Icon-83.5@2x.png",
      "idiom" : "ipad",
      "scale" : "2x",
      "size" : "83.5x83.5"
    },
    {
      "filename" : "Icon-1024.png",
      "idiom" : "ios-marketing",
      "scale" : "1x",
      "size" : "1024x1024"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
EOF

echo "  - Contents.json created"

# ============================================
# GENERATE ANDROID LAUNCHER XML
# ============================================
echo -e "\n${YELLOW}Generating Android ic_launcher.xml...${NC}"

mkdir -p android/mipmap-anydpi-v26

cat > android/mipmap-anydpi-v26/ic_launcher.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@mipmap/ic_launcher_background"/>
    <foreground android:drawable="@mipmap/ic_launcher_foreground"/>
</adaptive-icon>
EOF

echo "  - ic_launcher.xml created"

# ============================================
# SUMMARY
# ============================================
echo -e "\n${GREEN}================================${NC}"
echo -e "${GREEN}Icon Generation Complete!${NC}"
echo -e "${GREEN}================================${NC}\n"

echo "Generated files:"
echo "  📁 store/ (2 files)"
echo "    - ios-store-icon-1024.png"
echo "    - android-store-icon-512.png"
echo ""
echo "  📁 ios/ (14 files + Contents.json)"
echo "    - All iOS app icons"
echo ""
echo "  📁 android/ (18 files + ic_launcher.xml)"
echo "    - Standard launcher icons"
echo "    - Adaptive icon foreground layers"
echo "    - Adaptive icon background layers"
echo ""

echo -e "${YELLOW}Next Steps:${NC}"
echo "1. Review all generated icons"
echo "2. For iOS: Copy ios/* to ios/Runner/Assets.xcassets/AppIcon.appiconset/"
echo "3. For Android: Copy android/mipmap-*/* to android/app/src/main/res/"
echo "4. Upload store icons when submitting to App Store / Play Store"
echo ""
echo -e "${YELLOW}Note:${NC} Consider manually creating better foreground/background"
echo "      split for Android adaptive icons for optimal results."
echo ""
