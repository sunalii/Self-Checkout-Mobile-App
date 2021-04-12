import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/screens/existing_card_page.dart';
import 'package:selfcheckoutapp/services/payment_services.dart';

class PaymentPage extends StatefulWidget {
  @override
  _ExistingCardsPageState createState() => _ExistingCardsPageState();
}

class _ExistingCardsPageState extends State<PaymentPage> {
  //ON PRESSED ON CARDS
  onItemPress(BuildContext context, int index) async {
    switch (index) {
      case 0:
        var response = await StripeService.payWithNewCard(
            amount: '3000',
            currency: 'LKR'
        );
        if (response.success == true) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response.message),
            duration: Duration(milliseconds: 1200),
          ));
        }
        break;
      //DIRECTING TO PAY WITH EXISTING CARD PAGE
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExistingCardPage()),
        );
        break;
    }
  }


  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment",
          style: Constants.boldHeadingAppBar,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
            itemBuilder: (context, index) {
              Icon icon;
              Text text;

              switch (index) {
                case 0:
                  icon = Icon(Icons.add_rounded,
                      color: Theme.of(context).primaryColor);
                  text = Text("Pay via new card");
                  break;

                case 1:
                  icon = Icon(Icons.credit_card_rounded,
                      color: Theme.of(context).primaryColor);
                  text = Text("Pay via existing card");
                  break;
              }
              return InkWell(
                child: ListTile(
                  onTap: () {
                    onItemPress(context, index);
                  },
                  title: text,
                  leading: icon,
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
                  color: Theme.of(context).primaryColor,
                ),
            itemCount: 2),
      ),
    );
  }
}