import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/screens/payment.dart';

class CheckingPage extends StatefulWidget {
  final double total;
  final double totalWeight;

  const CheckingPage({
    Key key,
    this.total,
    this.totalWeight,
  }) : super(key: key);

  @override
  _CheckingPageState createState() => _CheckingPageState();
}

class _CheckingPageState extends State<CheckingPage> {
  void _compareWithCurrentWeight() async {
    await FlutterBarcodeScanner.scanBarcode(
            '#1faa00', "Cancel", true, ScanMode.QR)
        .then((value) {
      double qrWeight = double.parse(value);
      if (((widget.totalWeight - 10) < qrWeight) &&
          ((widget.totalWeight + 10) > qrWeight)) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentPage(
                    total: widget.total,
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
            content: Text('Cart weight is not equal. Please try again!'),
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Weight Checker",
            style: Constants.boldHeadingAppBar,
          ),
          leading: Icon(Icons.hourglass_bottom),
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
                      Text('Weight: ' + widget.totalWeight.toStringAsFixed(2) + 'kg',
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
      ),
    );
  }
}
