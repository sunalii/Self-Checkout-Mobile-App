import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/screens/home.dart';
import 'package:selfcheckoutapp/services/payment_services.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ExistingCardPage extends StatefulWidget {
  final double total;

  const ExistingCardPage({Key key, this.total}) : super(key: key);

  @override
  _ExistingCardPageState createState() => _ExistingCardPageState();
}

class _ExistingCardPageState extends State<ExistingCardPage> {
  //TYPE FROM THE STRIPE PAYMENT SDK WAS BEING USED
  List cards = [
    {
      'cardNumber': '4242424242424242',
      'expiryDate': '04/24',
      'cardHolderName': 'Sheyni',
      'cvvCode': '424',
      'showBackView': false,
    },
    {
      'cardNumber': '5555555555554444',
      'expiryDate': '04/23',
      'cardHolderName': 'Tracer',
      'cvvCode': '123',
      'showBackView': false,
    }
  ];

  //FUNCTION TO PAY
  payViaExistingCard(BuildContext context, card) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(
        message: 'Please wait...'
    );
    await dialog.show();
    var expiryArr = card['expiryDate'].split('/');
    CreditCard stripeCard = CreditCard(
      number: card['cardNumber'],
      expMonth: int.parse(expiryArr[0]),
      expYear: int.parse(expiryArr[1]),
    );
    var response = await StripeService.payViaExistingCard(
        amount: '${widget.total.toStringAsFixed(0)}00', //get total price
        currency: 'LKR',
        card: stripeCard
    );
    await dialog.hide();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.message),
          duration: new Duration(milliseconds: 1200),
        )
    ).closed.then((_) {
      print(widget.total);
      Navigator.push(
              context,
               MaterialPageRoute(builder: (context) => HomePage()),
            );
    });
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
