import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/widgets/bottom_tabs.dart';
import '../constants.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  String qrCode = 'unknown';

  Future _scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#1faa00', //HEX COLOR
          "Cancel", //CANCEL BUTTON TEXT
          true, //FLASH USE
          ScanMode.BARCODE //SCAN MODE --> QR, BARCODE, DEFAULT
          );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException catch (e) {
      setState(() {
        qrCode = "Error: $e";
      });
    }
  }

  List<CartList> cartItem = List<CartList>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shopping Cart",
          style: Constants.boldHeadingAppBar,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ListView.builder(
          //   itemCount: cartItem.length,
          //   itemBuilder: (context, index) {
          //     return Card(
          //         color: Colors.red,
          //         child: ListTile(
          //           contentPadding: EdgeInsets.symmetric(vertical: 20.0),
          //           title: Text(qrCode),
          //           subtitle: Text("Quantity: 2"),
          //           leading: Icon(Icons.home_rounded),
          //         )
          //     );
          //   },
          // ),
          CartBottomTab(),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 130.0,
          right: 8.0,
        ),
        child: Container(
          height: 60.0,
          width: 60.0,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.qr_code_rounded),
            onPressed: _scanQR,
          ),
        ),
      ),
      //bottomNavigationBar: BottomNavigationBar(),
    );
  }
}

class CartList {
}
