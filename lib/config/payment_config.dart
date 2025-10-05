import 'package:flutter/foundation.dart';

/// Payment configuration for Apple Pay and Google Pay
///
/// IMPORTANT: Before going to production:
/// 1. Replace placeholder merchant IDs with real ones
/// 2. Change environment from TEST to PRODUCTION
/// 3. Configure payment processor credentials
/// 4. Set up backend API for payment processing
class PaymentConfig {
  // Apple Pay Configuration
  static String get appleMerchantId {
    // TODO: Replace with your actual Apple Merchant ID
    // Get this from: https://developer.apple.com/account/resources/identifiers/list/merchant
    return kReleaseMode
        ? 'merchant.com.pierrescafe.production' // TODO: Replace with production merchant ID
        : 'merchant.com.pierrescafe.test'; // TODO: Replace with test merchant ID
  }

  static String get appleDisplayName => "Pierre's Cafe";

  static List<String> get appleMerchantCapabilities => ['3DS', 'debit', 'credit'];

  static List<String> get appleSupportedNetworks => ['visa', 'masterCard', 'amex', 'discover'];

  static String get appleCountryCode => 'US';

  static String get appleCurrencyCode => 'USD';

  // Google Pay Configuration
  static String get googlePayEnvironment {
    // IMPORTANT: Change to PRODUCTION before releasing to Play Store
    return kReleaseMode ? 'PRODUCTION' : 'TEST';
  }

  static String get googlePayGateway {
    // TODO: Replace 'example' with your actual payment gateway
    // Options: 'stripe', 'braintree', 'square', etc.
    return 'example'; // TODO: Change this!
  }

  static String get googlePayGatewayMerchantId {
    // TODO: Replace with your actual gateway merchant ID
    return kReleaseMode
        ? 'production_gateway_merchant_id' // TODO: Add production merchant ID
        : 'test_gateway_merchant_id'; // TODO: Add test merchant ID
  }

  static String get googlePayMerchantName => "Pierre's Cafe";

  static List<String> get googlePayAllowedCardNetworks => ['VISA', 'MASTERCARD', 'AMEX', 'DISCOVER'];

  static List<String> get googlePayAllowedAuthMethods => ['PAN_ONLY', 'CRYPTOGRAM_3DS'];

  static String get googlePayCountryCode => 'US';

  static String get googlePayCurrencyCode => 'USD';

  // Generate Apple Pay configuration JSON
  static String getApplePayConfig() {
    return '''{
      "provider": "apple_pay",
      "data": {
        "merchantIdentifier": "$appleMerchantId",
        "displayName": "$appleDisplayName",
        "merchantCapabilities": ${_toJsonArray(appleMerchantCapabilities)},
        "supportedNetworks": ${_toJsonArray(appleSupportedNetworks)},
        "countryCode": "$appleCountryCode",
        "currencyCode": "$appleCurrencyCode"
      }
    }''';
  }

  // Generate Google Pay configuration JSON
  static String getGooglePayConfig() {
    return '''{
      "provider": "google_pay",
      "data": {
        "environment": "$googlePayEnvironment",
        "apiVersion": 2,
        "apiVersionMinor": 0,
        "allowedPaymentMethods": [
          {
            "type": "CARD",
            "tokenizationSpecification": {
              "type": "PAYMENT_GATEWAY",
              "parameters": {
                "gateway": "$googlePayGateway",
                "gatewayMerchantId": "$googlePayGatewayMerchantId"
              }
            },
            "parameters": {
              "allowedCardNetworks": ${_toJsonArray(googlePayAllowedCardNetworks)},
              "allowedAuthMethods": ${_toJsonArray(googlePayAllowedAuthMethods)},
              "billingAddressRequired": false
            }
          }
        ],
        "merchantInfo": {
          "merchantName": "$googlePayMerchantName"
        },
        "transactionInfo": {
          "countryCode": "$googlePayCountryCode",
          "currencyCode": "$googlePayCurrencyCode"
        }
      }
    }''';
  }

  // Helper method to convert list to JSON array string
  static String _toJsonArray(List<String> items) {
    return '[${items.map((e) => '"$e"').join(', ')}]';
  }

  // Validation method to check if configuration is production-ready
  static bool isConfigurationValid() {
    if (!kReleaseMode) {
      return true; // In debug mode, any config is acceptable
    }

    // Check for placeholder values in production
    final hasPlaceholderApple = appleMerchantId.contains('test') ||
                                  appleMerchantId == 'merchant.com.pierrescafe.production';
    final hasPlaceholderGoogle = googlePayGateway == 'example' ||
                                  googlePayGatewayMerchantId.contains('test') ||
                                  googlePayGatewayMerchantId == 'production_gateway_merchant_id';

    return !hasPlaceholderApple && !hasPlaceholderGoogle;
  }

  // Get configuration warnings
  static List<String> getConfigurationWarnings() {
    final warnings = <String>[];

    if (appleMerchantId == 'merchant.com.pierrescafe.production' ||
        appleMerchantId == 'merchant.com.pierrescafe.test') {
      warnings.add('Apple Pay: Placeholder merchant ID detected. Replace with actual merchant ID.');
    }

    if (googlePayGateway == 'example') {
      warnings.add('Google Pay: Using example gateway. Replace with actual payment gateway (stripe, braintree, etc.).');
    }

    if (googlePayGatewayMerchantId == 'production_gateway_merchant_id' ||
        googlePayGatewayMerchantId == 'test_gateway_merchant_id') {
      warnings.add('Google Pay: Placeholder gateway merchant ID detected. Replace with actual merchant ID.');
    }

    if (kReleaseMode && googlePayEnvironment == 'TEST') {
      warnings.add('Google Pay: Running in TEST mode in production build. Change to PRODUCTION.');
    }

    return warnings;
  }
}
