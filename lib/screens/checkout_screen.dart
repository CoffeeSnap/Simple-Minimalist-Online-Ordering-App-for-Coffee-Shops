import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pay/pay.dart';
import '../providers/cart_provider.dart';
import '../config/payment_config.dart';
import 'order_confirmation_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _paymentItems = <PaymentItem>[];

  @override
  void initState() {
    super.initState();
    _initializePaymentItems();
  }

  void _initializePaymentItems() {
    final cart = Provider.of<CartProvider>(context, listen: false);
    _paymentItems.clear(); // Clear any existing items
    _paymentItems.add(
      PaymentItem(
        label: 'Total',
        amount: cart.totalAmount.toStringAsFixed(2),
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  void _onApplePayResult(Map<String, dynamic> result) {
    // Check for errors or cancellation
    if (result['error'] != null) {
      _showErrorDialog('Payment Failed', 'Apple Pay payment was not completed.');
      return;
    }
    _processPayment('Apple Pay');
  }

  void _onGooglePayResult(Map<String, dynamic> result) {
    // Check for errors or cancellation
    if (result['error'] != null) {
      _showErrorDialog('Payment Failed', 'Google Pay payment was not completed.');
      return;
    }
    _processPayment('Google Pay');
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _processPayment(String method) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Simulate payment processing
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Close loading

      final orderNumber = 'PC${DateTime.now().millisecondsSinceEpoch % 100000}';

      // Clear cart
      cart.clearCart();

      // Navigate to confirmation
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => OrderConfirmationScreen(
            orderNumber: orderNumber,
            paymentMethod: method,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    // Get payment configurations from centralized config
    final applePayConfig = PaymentConfig.getApplePayConfig();
    final googlePayConfig = PaymentConfig.getGooglePayConfig();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Summary
              Text(
                'Order Summary',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ...cart.items.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item.quantity}x ${item.menuItem.name}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                '\$${item.totalPrice.toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style:
                              Theme.of(context).textTheme.headlineMedium!.copyWith(
                                    fontSize: 20,
                                  ),
                        ),
                        Text(
                          '\$${cart.totalAmount.toStringAsFixed(2)}',
                          style:
                              Theme.of(context).textTheme.headlineMedium!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Payment Options
              Text(
                'Payment Method',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              // Apple Pay Button (iOS only)
              if (Platform.isIOS)
                ApplePayButton(
                  paymentConfiguration:
                      PaymentConfiguration.fromJsonString(applePayConfig),
                  paymentItems: _paymentItems,
                  style: ApplePayButtonStyle.black,
                  type: ApplePayButtonType.buy,
                  onPaymentResult: _onApplePayResult,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 16),
                ),
              // Google Pay Button (Android only)
              if (Platform.isAndroid)
                GooglePayButton(
                  paymentConfiguration:
                      PaymentConfiguration.fromJsonString(googlePayConfig),
                  paymentItems: _paymentItems,
                  type: GooglePayButtonType.buy,
                  onPaymentResult: _onGooglePayResult,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  width: double.infinity,
                  height: 50,
                ),
              // Fallback for other platforms
              if (!Platform.isIOS && !Platform.isAndroid)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Payment is only available on iOS and Android devices',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
