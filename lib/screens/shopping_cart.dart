import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/screens/checking_page.dart';
import 'package:selfcheckoutapp/services/firebase_services.dart';
import 'package:selfcheckoutapp/widgets/bottom_tabs.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String qrCode = '';
  bool getDataQr = false;

  List scanProducts = [];

  double total = 0;
  int totalWeight = 0;

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd-MM-yyyy hh:mm:ss');
  final String formatted = formatter.format(now);

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

  Future<List> _getData() async {
    if (this.getDataQr) {
      _firebaseServices.productsRef
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
    scanProducts.forEach((element) async {
      await _firebaseServices.usersCartRef.doc(_firebaseServices.getUserId()).collection("Cart").add({ //_firebaseServices.getUserId() = _user.uid
        'barcode': element['barcode'],
        'image': element['image'],
        'name': element['name'],
        'quantity': element['quantity'],
        'weight': element['weight'],
        'price': element['price'],
        'time': formatted
      });
    });
    _addToPay();
  }

  Future _addToPay() async {
    scanProducts.forEach((element) async {
      await _firebaseServices.usersPayRef.doc(_firebaseServices.getUserId()).set({
        'totalWeight': totalWeight,
        'totalPrice': total,
      });
    });
  }

  Future<bool> _onBackPressed() async {
    return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Leave?'),
                content: Text('Exiting cart will clear all your items.'),
                actions: [
                  TextButton(
                    child: Text(
                      "OK",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                  TextButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ],
              );
            }) ??
        false;
  }

  Future _checkCartItems() async {
    if (scanProducts.isNotEmpty) {
      setState(() {
        _addToCart().then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CheckingPage()),
          );
          // clearCart();
        });
      });
    } else {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Oh Empty Cart!'),
              content: Text('Start scanning to add items.'),
              actions: [
                TextButton(
                  child: Text(
                    "OK",
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          });
    }
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
                                key: Key(scanProducts[index].hashCode.toString()),
                                onDismissed: (direction) async {
                                  setState(() {
                                    scanProducts.removeAt(index);
                                    ScaffoldMessenger.of(context).showSnackBar(_snackBarItemDeleted);
                                  });
                                  total -= double.parse(snapshot.data[index]['price'].toString());
                                  totalWeight -= int.parse(snapshot.data[index]['weight'].toString());
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
                                              snapshot.data[index]['quantity'] += 1;
                                              total += double.parse(snapshot.data[index]['price'].toString());
                                              totalWeight += int.parse(snapshot.data[index]['weight'].toString());
                                            });
                                          },
                                          child: Text('+',
                                              style: TextStyle(
                                                  color: Colors.white))),
                                      Text(' Quantity:   ' + (snapshot.data[index]['quantity'].toString())),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: Color(0xff1faa00),
                                            minimumSize: Size(10.0, 5.0)),
                                        onPressed: () {
                                          setState(() {
                                            if (snapshot.data[index]['quantity'] > 1) {
                                              snapshot.data[index]['quantity'] -= 1;
                                              total -= double.parse(snapshot.data[index]['price'].toString());
                                              totalWeight -= int.parse(snapshot.data[index]['weight'].toString());
                                            }
                                          });
                                        },
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
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
                                Icons.remove_shopping_cart_rounded,
                                size: 50.0,
                                color: Colors.black26,
                              ),
                              Text(
                                "No items added.\nPress the Green button to start!",
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
                  _checkCartItems();
                  // _addToCart().then((value) {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => CheckingPage()),
                  //   );
                  //   clearCart();
                  // });
                },
              ),
              cartBottomTabTotal(total),
            ],
          ),
        ),
      ),
    );
  }
}


