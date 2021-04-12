import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/services/payment_services.dart';

class ExistingCardPage extends StatefulWidget {
  @override
  _ExistingCardPageState createState() => _ExistingCardPageState();
}

class _ExistingCardPageState extends State<ExistingCardPage> {
  List cards = [
    {
      'cardNumber': '4242424242424242',
      'expiryDate': '04/24',
      'cardHolderName': 'Sheyni',
      'cvvCode': '424',
      'showBackView': false,
    },
    {
      'cardNumber': '5555555566554444',
      'expiryDate': '04/23',
      'cardHolderName': 'Tracer',
      'cvvCode': '123',
      'showBackView': false,
    }
  ]; //TYPE FROM THE STRIPE PAYMENT SDK WAS BEING USED

  //FUNCTION TO PAY
  payViaExistingCard(BuildContext context, card) {
    var response = StripeService.payViaExistingCard(
        amount: '',
        currency: 'LKR',
        card: card
    );
    if (response.success == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.message),
        duration: Duration(milliseconds: 1200),
      )).closed.then((_) {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment via existing card",
          style: Constants.boldHeadingAppBar,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
            itemCount: cards.length,
            itemBuilder: (BuildContext context, int index) {
              var card = cards[index];
              return InkWell(
                onTap: () {
                  payViaExistingCard(context, card);
                },
                child: CreditCardWidget(
                  cardNumber: card['cardNumber'],
                  expiryDate: card['expiryDate'],
                  cardHolderName: card['cardHolderName'],
                  cvvCode: card['cvvCode'],
                  showBackView: false,
                ),
              );
            }),
      ),
    );
  }
}
