# Pierre's Cafe - Online Ordering App

A lightweight, fast Flutter app for ordering coffee and healthy patisseries from Pierre's Cafe.

## Features

- **Quick Ordering**: Minimal clicks for fast ordering experience
- **Menu Categories**: Coffee and Patisseries sections
- **Product Selection**:
  - Fresh brewed coffees (Espresso, Americano, Flat White, Cappuccino, Latte)
  - Iced coffee options
  - Healthy patisseries (Granola, Banana Bread, Oat Muffins, etc.)
- **Shopping Cart**: Easy add/remove items with quantity control
- **Payment Integration**: Apple Pay and Google Pay support
- **Beautiful UI**: Light brown, green, and pale yellow color scheme

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- iOS: Xcode for iOS development
- Android: Android Studio for Android development

### Installation

1. Install dependencies:
```bash
flutter pub get
```

2. Run the app:
```bash
# iOS
flutter run -d ios

# Android
flutter run -d android
```

## Payment Setup

### Apple Pay Configuration

To enable Apple Pay in production:

1. Add your Apple Merchant ID in `lib/screens/checkout_screen.dart`
2. Configure Apple Pay in your Apple Developer account
3. Update `ios/Runner/Info.plist` with payment processing entitlements

### Google Pay Configuration

To enable Google Pay in production:

1. Update the gateway and merchant ID in `lib/screens/checkout_screen.dart`
2. Change environment from "TEST" to "PRODUCTION"
3. Configure payment processor credentials

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   ├── menu_item.dart       # Data models
│   └── menu_data.dart       # Menu items data
├── providers/
│   └── cart_provider.dart   # State management
├── screens/
│   ├── menu_screen.dart     # Main menu
│   ├── cart_screen.dart     # Shopping cart
│   ├── checkout_screen.dart # Payment
│   └── order_confirmation_screen.dart
├── widgets/
│   ├── menu_item_card.dart  # Menu item UI
│   ├── cart_item_tile.dart  # Cart item UI
│   └── cart_fab.dart        # Floating action button
└── theme/
    └── app_theme.dart       # App colors and styling
```

## Color Palette

- **Light Brown**: #D4A574
- **Coffee Green**: #8BA888
- **Pale Yellow**: #FFF8DC
- **Cream**: #FFFAF0

## Dependencies

- `provider`: State management
- `pay`: Apple Pay and Google Pay integration
- `cupertino_icons`: iOS-style icons

## License

Copyright © 2025 Pierre's Cafe. All rights reserved.
