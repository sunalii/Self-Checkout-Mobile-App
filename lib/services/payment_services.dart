import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:selfcheckoutapp/services/firebase_services.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

FirebaseServices _firebaseServices = FirebaseServices();

class StripeTransactionResponse {
  String message;
  bool success;

  final double total;

  StripeTransactionResponse({this.total, this.message, this.success});
}

void _getFromCart() async {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
  final String formatted = formatter.format(now);

  _firebaseServices.usersCartRef
      .doc(_firebaseServices.getUserId())
      .collection("Cart")
      .get()
      .then((value) {
    List getFromCart = [value];
    print(getFromCart);
    getFromCart.forEach((element) async {
      _firebaseServices.usersPayCheckRef
          .doc(_firebaseServices.getUserId())
          .collection("Cart")
          .add({
        'barcode': element.barcode,
        'image': element.photo,
        'name': element.name,
        'quantity': element.quantity,
        'weight': element.weight,
        'price': element.price,
        'time': formatted
      });
    });
  });
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret =
      'sk_test_51IfMt7FnrKt7w8UFTDCpnIKVuctDGEYMyEEoCgnJPKW3EWOb8drDM1F0U6TQTvy7TxZmRoP945dG7HHjAB2ECCe000I6UErhny';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51IfMt7FnrKt7w8UFFUjOLYAsZINU5EuE9Qtst7zX2PEGhk5dAharCJQeFH0SdVuozRGQF4JgmfGtyqyfbuuKIAJO0028dxZ7CC",
        merchantId: "Test",
        androidPayMode: 'test'));
  }

  static Future<StripeTransactionResponse> payViaExistingCard(
      {String amount, String currency, CreditCard card}) async {
    try {
      var paymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(card: card));
      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id)); //CONFIRM PAYMENT
      if (response.status == 'succeeded') {
        //addToCart(itemsList);
        _getFromCart();

        return StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        return StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (e) {
      return StripeService.getPlatformExceptionErrorResult(e);
    } catch (e) {
      return StripeTransactionResponse(
          message: 'Transaction failed: ${e.toString()}', success: false);
    }
  }

  static Future<StripeTransactionResponse> payWithNewCard(
      {String amount, String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id)); //CONFIRM PAYMENT
      if (response.status == 'succeeded') {
        //addToCart(itemsList);
        _getFromCart();

        return StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        return StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (e) {
      return StripeService.getPlatformExceptionErrorResult(e);
    } catch (e) {
      return StripeTransactionResponse(
          message: 'Transaction failed: ${e.toString()}', success: false);
    }
  }

  static getPlatformExceptionErrorResult(e) {
    String message = 'Transaction failed. Something went wrong.';
    if (e.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return StripeTransactionResponse(message: message, success: false);
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(Uri.parse(StripeService.paymentApiUrl),
          body: body, headers: StripeService.headers);
      return jsonDecode(response.body);
    } catch (e) {
      print("e charging user: ${e.toString()}");
    }
    return null;
  }
}
