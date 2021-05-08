import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/models/item.dart';
import 'package:selfcheckoutapp/screens/payment.dart';
import 'package:selfcheckoutapp/services/firebase_services.dart';

class CheckingPage extends StatefulWidget {
  final double total;
  final double totalWeight;
  //final List<Item> itemsList;

  const CheckingPage({
    Key key,
    this.total,
    this.totalWeight,
    //this.itemsList,
  }) : super(key: key);

  @override
  _CheckingPageState createState() => _CheckingPageState();
}

class _CheckingPageState extends State<CheckingPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  void _compareWithCurrentWeight() async {
    await FlutterBarcodeScanner.scanBarcode(
            '#1faa00', "Cancel", true, ScanMode.QR)
        .then((value) {
          double qrWeight = double.parse(value);
      if (((widget.totalWeight - 10) < qrWeight) && ((widget.totalWeight + 10) > qrWeight)) {
        //_addToCart();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentPage(
                   total: widget.total,
                  // totalWeight: totalWeight,
                  // itemsList: [],
                  )),
        );
      } else
        _showConfirmationMessage();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _showConfirmationMessage() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Alert!'),
            content:
                Text('Cart weight is not equal. Please try again! Try again.'),
            actions: [
              TextButton(
                child: Text(
                  "Try again",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ],
          );
        });
  }

  // bool _checkingWeightLoading = false;
  //
  // void _submitCartValue() async {
  //   setState(() {
  //     _checkingWeightLoading = true;
  //   });
  //
  //   String _CartWeightFeedback = await _compareWithCurrentWeight();
  //   if(_CartWeightFeedback != null){
  //     _alertDialogBuilder(_CartWeightFeedback);
  //
  //     setState(() {
  //       _checkingWeightLoading = false;
  //     });
  //   }
  // }

  // Future<bool> _deleteCart() async {
  //   _firebaseServices.usersCartRef.doc(_firebaseServices.getUserId()).collection("Cart").snapshots().forEach((element) {
  //     for (QueryDocumentSnapshot snapshot in element.docs) {
  //       snapshot.reference.delete(); //first time -- add > delete //second time -- add and deleting at the same time
  //     }
  //     _goBack();
  //   });
  //  return _goBack();
  // }
  //
  // _goBack() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => ShoppingCartPage()),
  //   );
  // }

  ///Need to use this
  // void _addToCart() async {
  //   widget.itemsList.forEach((element) async {
  //     await _firebaseServices.usersCartRef
  //         .doc(_firebaseServices.getUserId())
  //         .collection("Cart")
  //         .add({
  //       'barcode': element.barcode,
  //       'image': element.photo,
  //       'name': element.name,
  //       'quantity': element.quantity,
  //       'weight': element.weight,
  //       'price': element.price,
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Weight Checker",
            style: Constants.boldHeadingAppBar,
          ),
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Users Cart'),
                      Text('Total: LKR ' + widget.total.toString() + '0',
                          style: TextStyle(fontSize: 32)),
                      Text('Weight: ' + widget.totalWeight.toString() + 'g',
                          style: TextStyle(fontSize: 32)),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text(
                  'Check',
                  style: TextStyle(fontSize: 18.0),
                ),
                onPressed: () {
                _compareWithCurrentWeight();
              },
              ),
            ),
            Row(),
          ],
        ),
    );
  }
}
