class StripeTransactionResponse {
  String message;
  bool success;

  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.co//v1';
  static String secret = '';

  static init(){}

  static StripeTransactionResponse payViaExistingCard({String amount, String currency, card}) {
    return StripeTransactionResponse(
      message: 'Transaction successful',
      success: true
    );
  }

  static StripeTransactionResponse payWithNewCard({String amount, String currency}) {
    return StripeTransactionResponse(
        message: 'Transaction successful',
        success: true
    );
  }
}