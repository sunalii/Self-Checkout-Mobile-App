import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/screens/payment.dart';
import 'package:selfcheckoutapp/services/firebase_services.dart';
import 'package:selfcheckoutapp/widgets/custom_button.dart';
import 'package:selfcheckoutapp/widgets/custom_input.dart';

//
// class CheckingPage extends StatefulWidget {
//   @override
//   _CheckingPageState createState() => _CheckingPageState();
// }
//
// class _CheckingPageState extends State<CheckingPage> {
//   FirebaseServices _firebaseServices = FirebaseServices();
//   TextEditingController _userCartController = TextEditingController();
//
//   //String _userCartController = '';
//
//   int totalWeight = 45;
//
//   Future _compareWithCurrentWeight() async {
// //   db = FirebaseDatabase.instance.reference().child("UsersPayCheck");
// //   db.equalTo(Id).once().then((DataSnapshot snapshot){
// //     Map<dynamic, dynamic> values = snapshot.value;
// //     values.forEach((key,values) {
// //       print(values["name"]);
// //     });
// //   });
// //
//     if (_userCartController == totalWeight) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => PaymentPage()),
//       );
//     } else {
//       return _showConfirmationMessage();
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   Future<bool> _showConfirmationMessage() async {
//     return showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: Text('Alert!'),
//                 content: Text(
//                     'Cart weight is not equal. Please try again! Try again.'),
//                 actions: [
//                   TextButton(
//                     child: Text(
//                       "Checkout",
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => PaymentPage()),
//                       );
//                     },
//                   ),
//                   TextButton(
//                     child: Text(
//                       "Try again",
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     onPressed: () => Navigator.of(context).pop(false),
//                   ),
//                 ],
//               );
//             }) ??
//         false;
//   }
//
//   // bool _checkingWeightLoading = false;
//   //
//   // void _submitCartValue() async {
//   //   setState(() {
//   //     _checkingWeightLoading = true;
//   //   });
//   //
//   //   String _CartWeightFeedback = await _compareWithCurrentWeight();
//   //   if(_CartWeightFeedback != null){
//   //     _alertDialogBuilder(_CartWeightFeedback);
//   //
//   //     setState(() {
//   //       _checkingWeightLoading = false;
//   //     });
//   //   }
//   // }
//
//   Future<bool> _deleteCart() async {
//     _firebaseServices.usersCartRef
//         .doc(_firebaseServices.getUserId())
//         .collection("Cart")
//         .snapshots()
//         .forEach((element) {
//       for (QueryDocumentSnapshot snapshot in element.docs) {
//         snapshot.reference
//             .delete(); //first time -- add > delete //second time -- add and deleting at the same time
//       }
//       // _goBack();
//     });
//     // return _goBack();
//   }
//
//   // _goBack() {
//   //   Navigator.push(
//   //     context,
//   //     MaterialPageRoute(builder: (context) => ShoppingCartPage()),
//   //   );
//   // }
//
//   Future _getData() async {
//     return await _firebaseServices.usersPayCheckRef
//         .doc(_firebaseServices.getUserId())
//         .collection('Cart')
//         .get();
//   }
//
//   Stream<QuerySnapshot> getUsersPastTripsStreamSnapshots(
//       BuildContext context) async* {}
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _deleteCart,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "Weight Checker",
//             style: Constants.boldHeadingAppBar,
//           ),
//           textTheme: GoogleFonts.poppinsTextTheme(),
//         ),
//         body: Container(
//           padding: EdgeInsets.only(
//             bottom: 50.0,
//           ),
//           width: double.infinity,
//           child: FutureBuilder(
//               future: _getData(), //users email
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return Scaffold(
//                     body: Center(
//                       child: Text("Error: ${snapshot.error}"),
//                     ),
//                   );
//                 }
//
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   if (snapshot.hasData != null) {
//                     return Container(
//                       //color: Colors.pink,
//                       child: snapshot.data.docs.map((documents) {
//                         Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   "Total Weight:   ${documents.data()['totalWeight']} Grams",
//                                   style: Constants.boldHeading,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   "Total Price:   LKR ${documents.data()['totalPrice']}0",
//                                   style: Constants.boldHeading,
//                                 ),
//                               ),
//                               Divider(),
//                               CustomInput(
//                                 //controller: _userCartController,
//                                 onChanged: (value) {
//                                   print("CART NUMBER");
//                                 },
//                                 onSubmitted: (value) {
//                                   // _submitCartValue();
//                                 },
//                                 hintText: "Enter Your Cart Number...",
//                                 textInputType: TextInputType.number,
//                                 textCapitalization: TextCapitalization.none,
//                               ),
//                               CustomBtn(
//                                 text: "Check Weight",
//                                 onPressed: () {
//                                   if (_userCartController != null) {
//                                     _compareWithCurrentWeight();
//                                   }
//                                   //_submitCartValue(),
//                                 },
//                                 //isLoading: _checkingWeightLoading(),
//                               ),
//                             ]);
//                       }).toList(),
//                     );
//                   }
//                 } else {
//                   return Scaffold(
//                     body: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   );
//                 }
//
//                 return Scaffold(
//                   body: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//               }),
//         ),
//       ),
//     );
//   }
// }

class CheckingPage extends StatefulWidget {
  @override
  _CheckingPageState createState() => _CheckingPageState();
}

class _CheckingPageState extends State<CheckingPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  TextEditingController _userCartController = TextEditingController();

  //String _userCartController = '';

  int totalWeight = 45;

  Future _compareWithCurrentWeight() async {
//   db = FirebaseDatabase.instance.reference().child("UsersPayCheck");
//   db.equalTo(Id).once().then((DataSnapshot snapshot){
//     Map<dynamic, dynamic> values = snapshot.value;
//     values.forEach((key,values) {
//       print(values["name"]);
//     });
//   });
//
    if (_userCartController == totalWeight) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentPage()),
      );
    } else {
      return _showConfirmationMessage();
    }
  }

  Future<bool> _showConfirmationMessage() async {
    return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Alert!'),
                content: Text(
                    'Cart weight is not equal. Please try again! Try again.'),
                actions: [
                  TextButton(
                    child: Text(
                      "Checkout",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaymentPage()),
                      );
                    },
                  ),
                  TextButton(
                    child: Text(
                      "Try again",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ],
              );
            }) ??
        false;
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

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _deleteCart() async {
    _firebaseServices.usersCartRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .snapshots()
        .forEach((element) {
      for (QueryDocumentSnapshot snapshot in element.docs) {
        snapshot.reference
            .delete(); //first time -- add > delete //second time -- adding and deleting at the same time ..error

      }
    });
    Navigator.of(context).pop();
  }

  // _goBack() {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => ShoppingCartPage()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _deleteCart,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Weight Checker",
            style: Constants.boldHeadingAppBar,
          ),
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        body: Container(
          padding: EdgeInsets.only(
            bottom: 50.0,
          ),
          width: double.infinity,
          child: FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.usersPayCheckRef.get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: snapshot.data.docs.map((documents) {
                      return Container(
                        //color: Colors.pink,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Total Weight:   ${documents.data()['totalWeight']} Grams",
                                style: Constants.boldHeading,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Total Price:   LKR ${documents.data()['totalPrice']}0",
                                style: Constants.boldHeading,
                              ),
                            ),
                            Divider(),
                            CustomInput(
                              //controller: _userCartController,
                              onChanged: (value) {
                                print("CART NUMBER");
                              },
                              onSubmitted: (value) {
                                // _submitCartValue();
                              },
                              hintText: "Enter Your Cart Number...",
                              textInputType: TextInputType.number,
                              textCapitalization: TextCapitalization.none,
                            ),
                            CustomBtn(
                              text: "Check Weight",
                              onPressed: () {
                                if (_userCartController != null) {
                                  _compareWithCurrentWeight();
                                }
                                //_submitCartValue(),
                              },
                              //isLoading: _checkingWeightLoading(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }

                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
