import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/widgets/bottom_tabs.dart';
import '../constants.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  String qrCode = '';

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

  List<Products> cartItem = <Products>[];

  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");



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
      body: SafeArea(
        child: Container(
            child: FutureBuilder<QuerySnapshot>(
              future: _productsRef.get(),
              builder: (context, snapshot){
                if (snapshot.hasError){
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                if(snapshot.connectionState == ConnectionState.done){
                   if(qrCode == "4792240001010"){
                    return ListView(
                      children: snapshot.data.docs.map((document){
                        return Container(
                          height: 80.0,
                          width: double.infinity,
                          child: Card(
                            child: ListTile(
                              leading: Image.network("${document.data()['image']}"),
                              trailing: Text("LKR ${document.data()['price']}"),
                              title: Text("${document.data()['name']}"),
                              subtitle: Text("Quantity"),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                }

                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 20.0,
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
      bottomNavigationBar: Container(child: CartBottomTab()),
    );
  }

  Widget buildBodyList() {
    return ListView.builder(
      itemCount: cartItem.length,
      itemBuilder: (context, index) {
        return buildCartListItem(cartItem[index]);
      },
    );
  }

  Widget buildCartListItem(Products items) {
    return Container(
      height: 80.0,
      width: double.infinity,
      child: Card(
        child: ListTile(
          leading: Icon(Icons.home),
          trailing: Text("Price"),
          title: Text(qrCode),
          subtitle: Text("Quantity"),
        ),
      ),
    );
  }

  Widget buildEmptyBody() {
    return Center(
      child: Text("No items added"),
    );
  }
}

class Products {
  final String name;
  final String image;
  final int price;
  final String weight;

  Products(this.name, this.image, this.price, this.weight);
}

class DatabaseServices {
  final String uid;

  DatabaseServices({this.uid});
}