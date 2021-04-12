import 'dart:convert';

import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String message;
  bool success;

  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.co//v1';
  static String secret = '';

  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51IfMt7FnrKt7w8UFFUjOLYAsZINU5EuE9Qtst7zX2PEGhk5dAharCJQeFH0SdVuozRGQF4JgmfGtyqyfbuuKIAJO0028dxZ7CC",
        merchantId: "Test",
        androidPayMode: 'test'));
  }

  static StripeTransactionResponse payViaExistingCard(
      {String amount, String currency, card}) {
    return StripeTransactionResponse(
        message: 'Transaction successful', success: true);
  }

  static Future<StripeTransactionResponse> payWithNewCard(
      {String amount, String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      print(jsonEncode(paymentMethod));
      return StripeTransactionResponse(
          message: 'Transaction successful',
          success: true);
    } catch (e) {
      return StripeTransactionResponse(
          message: 'Transaction failed: ${e.toString()}',
          success: true);
    }
  }

  static createPaymentIntent(String amount, String currency) async {

  }
}
