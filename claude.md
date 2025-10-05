# Pierre's Cafe - Flutter Ordering App

## Project Overview

A lightweight, mobile-first online ordering application for Pierre's Cafe, built with Flutter for iOS and Android platforms. The app prioritizes speed and minimal user interactions to provide the fastest ordering experience possible.

## Business Requirements

### Target Users
- Coffee shop customers who want quick mobile ordering
- Users who prefer contactless payment options
- Health-conscious customers looking for healthy food options

### Core Use Cases
1. Browse menu items quickly with visual categories
2. Add items to cart with minimal taps
3. Review and modify order
4. Complete purchase using Apple Pay or Google Pay
5. Receive order confirmation

## Technical Architecture

### State Management
- **Provider Pattern**: Used for cart state management across the app
- `CartProvider` manages all cart operations (add, remove, clear, calculate totals)

### Navigation Flow
```
MenuScreen (Home)
    ↓
CartScreen (Review Order)
    ↓
CheckoutScreen (Payment)
    ↓
OrderConfirmationScreen (Success)
    ↓
MenuScreen (Loop back)
```

### Key Design Decisions

1. **Minimal Click Philosophy**
   - Direct add-to-cart from menu grid
   - In-place quantity adjustment
   - One-tap category switching
   - Single button checkout flow

2. **Color System**
   - Primary: Light Brown (#D4A574) - Warmth, coffee aesthetic
   - Secondary: Coffee Green (#8BA888) - Natural, healthy
   - Surface: Pale Yellow (#FFF8DC) - Soft, inviting
   - Background: Cream (#FFFAF0) - Clean, comfortable

3. **Payment Strategy**
   - Native payment buttons for trust and familiarity
   - Support for both iOS (Apple Pay) and Android (Google Pay)
   - No manual card entry required

## Menu Structure

### Coffee Items (9 varieties)
- **Hot Coffees**: Espresso, Americano, Flat White, Latte, Cappuccino, Black Coffee
- **Iced Coffees**: Iced Americano, Iced Latte, Iced Coffee
- Price range: $3.00 - $5.00

### Patisserie Items (6 healthy options)
- Almond Croissant
- Granola Bowl
- Banana Bread
- Oat Muffin
- Protein Energy Balls
- Avocado Toast
- Price range: $3.50 - $7.00

## Component Breakdown

### Screens (4)
1. **MenuScreen**: Main browsing interface with category tabs
2. **CartScreen**: Order review with edit capabilities
3. **CheckoutScreen**: Payment processing with Apple/Google Pay
4. **OrderConfirmationScreen**: Success state with order details

### Widgets (3)
1. **MenuItemCard**: Grid item with emoji, details, and add controls
2. **CartItemTile**: List item showing quantity and subtotal
3. **CartFAB**: Floating action button with cart count and total

### Models (2)
1. **MenuItem**: Product data structure with category and pricing
2. **CartItem**: Cart entry with quantity and calculated totals

### Providers (1)
1. **CartProvider**: Centralized cart state with ChangeNotifier

## File Structure

```
lib/
├── main.dart                          # App entry, provider setup
├── models/
│   ├── menu_item.dart                # Data models, enums
│   └── menu_data.dart                # Static menu data
├── providers/
│   └── cart_provider.dart            # Cart state management
├── screens/
│   ├── menu_screen.dart              # Home screen with menu grid
│   ├── cart_screen.dart              # Cart review screen
│   ├── checkout_screen.dart          # Payment screen
│   └── order_confirmation_screen.dart # Success screen
├── widgets/
│   ├── menu_item_card.dart           # Menu item component
│   ├── cart_item_tile.dart           # Cart item component
│   └── cart_fab.dart                 # Cart floating button
└── theme/
    └── app_theme.dart                # Colors, styles, theme data
```

## Implementation Details

### State Management Flow
```dart
User Action → Provider Method → notifyListeners() → UI Rebuild
```

Example:
```dart
onTap: Add Button
  ↓
cart.addItem(menuItem)
  ↓
CartProvider._items.add()
  ↓
notifyListeners()
  ↓
Consumer<CartProvider> rebuilds
```

### Payment Integration
- Uses `pay` package (^2.0.0)
- Supports platform-specific payment configurations
- Simulates 2-second processing delay
- Generates unique order numbers

### Data Models

**MenuItem**
- Unique ID
- Name, description, emoji
- Price (double)
- Category (enum)
- Temperature (optional enum for coffee)

**CartItem**
- MenuItem reference
- Quantity (mutable)
- Calculated total price

## Performance Optimizations

1. **Grid Layout**: Fixed cross-axis count for predictable performance
2. **Const Constructors**: Used throughout for widget reuse
3. **Provider Scoping**: Only rebuilds necessary widgets
4. **Asset Optimization**: Uses emoji instead of images (zero asset loading)

## UX Considerations

### Speed Optimizations
- No login required
- No multi-step forms
- Default quantities to 1
- Persistent cart badge
- Direct navigation paths

### Accessibility
- High contrast text
- Large tap targets (minimum 44x44)
- Clear visual hierarchy
- Readable font sizes (14-32pt)

### Error Prevention
- Clear cart confirmation dialog
- Visual quantity feedback
- Total price always visible
- Payment loading indicators

## Testing Strategy

### Manual Testing Checklist
- [ ] Add items to cart from menu
- [ ] Modify quantities in cart
- [ ] Remove items from cart
- [ ] Clear entire cart
- [ ] Switch between categories
- [ ] View order summary in checkout
- [ ] Simulate payment flow
- [ ] Verify order confirmation
- [ ] Return to menu from confirmation

### Edge Cases
- Empty cart state
- Maximum quantity handling
- Navigation back button behavior
- Payment cancellation flow

## Production Deployment Requirements

### iOS Setup
1. Configure Apple Merchant ID in Apple Developer portal
2. Update `merchantIdentifier` in checkout_screen.dart
3. Add payment processing entitlements in Info.plist
4. Test on physical device (required for Apple Pay)
5. Submit for App Store review

### Android Setup
1. Register with payment gateway
2. Update `gatewayMerchantId` in checkout_screen.dart
3. Change environment from "TEST" to "PRODUCTION"
4. Configure merchant account
5. Test on physical device
6. Submit to Google Play

### Backend Integration (Future)
- Order submission API endpoint
- Payment processing webhook
- Order status updates
- Push notifications for order ready
- Order history retrieval

## Future Enhancements

### Phase 2 Features
- [ ] User accounts and order history
- [ ] Loyalty points system
- [ ] Saved favorite orders
- [ ] Customization options (milk type, sugar, etc.)
- [ ] Pickup time selection
- [ ] Store location selector

### Phase 3 Features
- [ ] Push notifications
- [ ] Real-time order tracking
- [ ] In-app tips
- [ ] Dietary filters (vegan, gluten-free)
- [ ] Reviews and ratings
- [ ] Referral program

## Dependencies

```yaml
dependencies:
  flutter: sdk
  provider: ^6.1.1      # State management
  pay: ^2.0.0           # Payment processing
  cupertino_icons: ^1.0.6

dev_dependencies:
  flutter_test: sdk
  flutter_lints: ^3.0.0
```

## Maintenance Notes

### Updating Menu Items
Edit `lib/models/menu_data.dart`:
```dart
MenuItem(
  id: 'unique_id',
  name: 'Product Name',
  description: 'Short description',
  price: 4.50,
  category: ItemCategory.coffee,
  emoji: '☕',
)
```

### Changing Colors
Edit `lib/theme/app_theme.dart`:
```dart
static const Color lightBrown = Color(0xFFD4A574);
static const Color coffeeGreen = Color(0xFF8BA888);
// etc...
```

### Payment Configuration
Edit `lib/screens/checkout_screen.dart`:
- Line 32: `merchantIdentifier` for Apple Pay
- Line 56: `gatewayMerchantId` for Google Pay

## Support & Documentation

- Flutter Docs: https://docs.flutter.dev
- Provider Package: https://pub.dev/packages/provider
- Pay Package: https://pub.dev/packages/pay
- Apple Pay Guide: https://developer.apple.com/apple-pay
- Google Pay Guide: https://developers.google.com/pay

---

**Built with Flutter • Designed for Speed • Made with ☕**
