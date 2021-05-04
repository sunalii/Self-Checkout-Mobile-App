import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:selfcheckoutapp/services/firebase_services.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

FirebaseServices _firebaseServices = FirebaseServices();

class StripeTransactionResponse {
  String message;
  bool success;

  StripeTransactionResponse({this.message, this.success});
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
        //cartAddedToBill();
        //addToCart();

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
        //cartAddedToBill();
        //_cartPage.addToCart();

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

  static Future<Map<String, dynamic>> createPaymentIntent(String amount,
      String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(StripeService.paymentApiUrl,
          body: body, headers: StripeService.headers);
      return jsonDecode(response.body);
    } catch (e) {
      print("e charging user: ${e.toString()}");
    }
    return null;
  }

//   static void addToCart() {
//     scanProducts.forEach((element) async {
//       await _firebaseServices.usersCartRef.doc(_firebaseServices.getUserId()).collection("Cart").add({ //_firebaseServices.getUserId() = _user.uid
//         'barcode': element['barcode'],
//         'name': element['name'],
//         'quantity': element['quantity'],
//         'weight': element['weight'],
//         'price': element['price'],
//         'time': formatted
//       });
//     });
//   }
// }

  Future<void> cartAddedToBill() async {
    // User user = _firebaseServices.getUserId();
    // print(user.uid);
    _firebaseServices.usersCartRef.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        _firebaseServices.usersCartRef.doc(_firebaseServices.getUserId())
            .collection("Cart").get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((result) {
            FirebaseFirestore
                .instance
                .collection('BillHistory')
                .doc(_firebaseServices.getUserId())
            //  .add({
            // 'barcode': barcode,
            // 'name': name,
            // 'quantity': quantity,
            // 'weight': weight,
            // 'price': price,
            //})
                ;
            //print(result.data);
          });
        });
      });
    });
  }
}

