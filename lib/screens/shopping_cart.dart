import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/screens/checking_page.dart';
import 'package:selfcheckoutapp/widgets/bottom_tabs.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingCartPage extends StatefulWidget {
  // final String productId;
  //
  // const ShoppingCartPage({Key key, this.productId}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  String qrCode = '';
  bool getDataQr = false;

  List scanProducts = [];

  double total = 0;
  int totalWeight = 0;

  final SnackBar _snackBarItemAdded =
      SnackBar(content: Text("Item added to cart"));
  final SnackBar _snackBarItemDeleted =
      SnackBar(content: Text("Item removed from cart"));

  @override
  void initState() {
    super.initState();
    //this.getData();
  }

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
        this.getDataQr = true;
        //_getData();
        // _addToCart();
      });
    } on PlatformException catch (e) {
      setState(() {
        qrCode = "Error: $e";
      });
    }
  }

  // final CollectionReference _productsRef = FirebaseFirestore.instance
  //     .collection("Products");

  Future<List> _getData() async {
    //print(this.qrCode.runtimeType);

    // CollectionReference _productsRef =
    //     FirebaseFirestore.instance.collection("Products");

    //print('grower ${_productsRef.get()}');

    if (this.getDataQr) {
      FirebaseFirestore.instance
          .collection('Products')
          .where('barcode', isEqualTo: this.qrCode)
          .snapshots()
          .listen((data) {
        data.docs.forEach((element) {
          setState(() {
            scanProducts.add(element.data());
            total += double.parse(element['price'].toString());
            totalWeight += int.parse(element['weight'].toString());
            this.getDataQr = false;
            ScaffoldMessenger.of(context).showSnackBar(_snackBarItemAdded);
          });
          //return scanProducts;
        });
      });
    }
    return scanProducts;
  }

  Future _addToCart() async {
    final CollectionReference _usersRef = FirebaseFirestore.instance.collection(
        'Users'); // TO STORE USERS CART | User-->userId->Cart-->productId

    User _user = FirebaseAuth.instance.currentUser;

    scanProducts.forEach((element) async {
      await _usersRef.doc(_user.uid).collection("Cart").add({
        'barcode': element['barcode'],
        'name': element['name'],
        'quantity': element['quantity'],
        'weight': element['weight'],
        'price': element['price'],
      });
    });
    _addToPay();
  }

  Future _addToPay() async {
    final CollectionReference _usersRef =
        FirebaseFirestore.instance.collection("UsersPayCheck");

    User _user = FirebaseAuth.instance.currentUser;

    scanProducts.forEach((element) async {
      await _usersRef.doc(_user.uid).collection("CartPayCheck").add({
        'totalWeight': totalWeight,
        'totalPrice': total,
      });
    });
  }

  void deleteCartItem(index) async {
    CollectionReference cartItem =
        FirebaseFirestore.instance.collection('Users');
    User _user = FirebaseAuth.instance.currentUser;
    setState(() {
      scanProducts.forEach((element) async {
        cartItem
            .doc(_user.uid)
            .delete()
            .then((value) => print("User Deleted"))
            .catchError((error) => print("Failed to delete user: $error"));

        ScaffoldMessenger.of(context).showSnackBar(_snackBarItemDeleted);
      });
      scanProducts.removeAt(index);
    });
  }

  clearCart() {
    setState(() {
      scanProducts.clear();
    });
  }

  // //double total = 0;
  // double price = 0;
  //
  // Future getTotal() async {
  //
  //   double total = 0;
  //   //double price = 0;
  //
  //   FirebaseFirestore.instance
  //       .collection('Priducts')
  //       .where('barcode', isEqualTo: this.qrCode)
  //       .snapshots()
  //       .listen((data) {
  //      data.docs.forEach((element) {
  //        setState(() {
  //          total = double.parse(element['price'].toString());
  //          price = total;
  //          return price;
  //        });
  //      });
  //   });
  //   return total;
  // }

  Future<bool> _onBackPressed() {
    return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Leave?'),
                content: Text('Exiting cart will clear all your items.'),
                actions: [
                  TextButton(
                    child: Text(
                      "Yes",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      clearCart();
                    },
                  ),
                  TextButton(
                    child: Text(
                      "No",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ],
              );
            }) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Shopping Cart",
              style: Constants.boldHeadingAppBar,
            ),
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          body: SafeArea(
            child: Container(
              child: FutureBuilder(
                future: _getData(),
                builder: (context, AsyncSnapshot snapshot) {
                  print("FutureBuilder Hello: ${snapshot.data}");
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error: ${snapshot.error}"),
                      ),
                    );
                  }

                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0) {
                      //if (qrCode == 'barcode') {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            //print("document ${document}");
                            return Container(
                              height: 120.0,
                              width: double.infinity,
                              child: Card(
                                child: Dismissible(
                                  key: Key(scanProducts.toString()),
                                  //HAS TO GIVE A UNIQUE KEY TO IDENTIFY THE DISMISS TILE
                                  onDismissed: (direction) async {
                                    setState(() {
                                      scanProducts.remove(index);
                                    });
                                  },
                                  direction: DismissDirection.startToEnd,
                                  background: Container(
                                    color: Color(0xffD50000),
                                    child: Icon(Icons.delete_rounded,
                                        color: Colors.white),
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 15.0),
                                  ),
                                  child: ListTile(
                                    leading: Image.network(
                                        "${snapshot.data[index]['image']}"),
                                    trailing: Text(
                                        "LKR ${snapshot.data[index]['price']}"),
                                    title: Text(
                                      "${snapshot.data[index]['name']}",
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xff1faa00),
                                                minimumSize: Size(10.0, 5.0)),
                                            onPressed: () {
                                              setState(() {
                                                snapshot.data[index]
                                                    ['quantity'] += 1;
                                                total += double.parse(snapshot
                                                    .data[index]['price']
                                                    .toString());
                                                totalWeight += int.parse(
                                                    snapshot.data[index]
                                                            ['weight']
                                                        .toString());
                                              });
                                            },
                                            child: Text('+',
                                                style: TextStyle(
                                                    color: Colors.white))),
                                        Text(' Quantity:   ' +
                                            (snapshot.data[index]['quantity']
                                                .toString())),
                                        TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xff1faa00),
                                                minimumSize: Size(10.0, 5.0)),
                                            onPressed: () {
                                              setState(() {
                                                if (snapshot.data[index]
                                                        ['quantity'] >
                                                    1) {
                                                  snapshot.data[index]
                                                      ['quantity'] -= 1;
                                                  total -= double.parse(snapshot
                                                      .data[index]['price']
                                                      .toString());
                                                  totalWeight -= int.parse(
                                                      snapshot.data[index]
                                                              ['weight']
                                                          .toString());
                                                }
                                              });
                                            },
                                            child: Text('-',
                                                style: TextStyle(
                                                    color: Colors.white))),
                                      ],
                                    ),
                                    //dense: true,
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Scaffold(
                        body: Container(
                          child: Center(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Icon(
                                  Icons.remove_shopping_cart,
                                  size: 50.0,
                                ),
                                Text(
                                  "No items added.\nPress the button to start!",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
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
          bottomNavigationBar: Container(
            height: 120.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1.0,
                  blurRadius: 20.0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CartBottomTabBtn(
                  onPressed: () {
                    _addToCart().then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CheckingPage()),
                      );
                      clearCart();
                    });
                  },
                ),
                cartBottomTabTotal(total),
              ],
            ),
          )),
    );
  }
}
