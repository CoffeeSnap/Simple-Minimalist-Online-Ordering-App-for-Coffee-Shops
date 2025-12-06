# Pierre's Cafe - Online Ordering App

A lightweight, fast Flutter app for ordering coffee and healthy patisseries from Pierre's Cafe 🥐

[![Online Ordering App - Pierre's Cafe](https://i1.ytimg.com/vi/WIaE4JB1vcg/sddefault.jpg)](https://www.youtube.com/watch?v=WIaE4JB1vcg)

**[Click here to watch the full video on YouTube  →](https://www.youtube.com/watch?v=WIaE4JB1vcg)**


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

## Project Branding Color Palette

- **Light Brown**: #D4A574
- **Coffee Green**: #8BA888
- **Pale Yellow**: #FFF8DC
- **Cream**: #FFFAF0


## The Author

[![Pierre-Henry Soria](https://avatars0.githubusercontent.com/u/1325411?s=200)](https://ph7.me)

Made with ❤️ by **[Pierre-Henry Soria](https://pierrehenry.be)** — an AI Data Scientist & Senior Software Engineer. Incredibly passionate about AI, machine learning, data science, and emerging technologies. I could happily talk all night about programming and IT with anyone who’s keen. Roquefort 🧀, ristretto ☕️, and dark chocolate lover! 😋


## License

Generously distributed under the [MIT License](LICENSE.md)


[![@phenrysay](https://img.shields.io/badge/x-000000?style=for-the-badge&logo=x)](https://x.com/phenrysay "Follow Me on X")  [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/pH-7 "My GitHub")  [![YouTube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/@pH7Programming/videos "Subscribe to my YouTube Channel")  [![BlueSky](https://img.shields.io/badge/BlueSky-00A8E8?style=for-the-badge&logo=bluesky&logoColor=white)](https://bsky.app/profile/ph7s.bsky.social "Follow Me on BlueSky")
