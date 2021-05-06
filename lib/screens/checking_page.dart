import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/screens/payment.dart';
import 'package:selfcheckoutapp/services/firebase_services.dart';

import 'payment.dart';


class CheckingPage extends StatefulWidget {
  final double total;
  final double totalWeight;

  const CheckingPage({Key key, this.total, this.totalWeight,}) : super(key: key);

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

    double y = 100;

    if (((widget.totalWeight - 50) < y) && ((widget.totalWeight+50) > y)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentPage()),
      );
    } else {
      return _showConfirmationMessage();
    }
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

  Future _getData() async {
    return await _firebaseServices.usersPayCheckRef
        .doc(_firebaseServices.getUserId())
        .collection('Cart')
        .get();
  }

  Stream<QuerySnapshot> getUsersPastTripsStreamSnapshots(
      BuildContext context) async* {}

  @override
  Widget build(BuildContext context) {
    return
      // WillPopScope(
      // onWillPop: _deleteCart,
      // child:
      Scaffold(
          appBar: AppBar(
            title: Text(
              "Weight Checker",
              style: Constants.boldHeadingAppBar,
            ),
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Users Cart'),
                        Text('Total: LKR '+widget.total.toString(),
                            style: TextStyle(fontSize: 32)),
                        Text('Weight: '+widget.totalWeight.toString()+'g',
                            style: TextStyle(fontSize: 32))
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('System Cart'),
                        Text('Total: LKR '+widget.total.toString(),
                            style: TextStyle(fontSize: 32)),
                        Text('Weight: '+widget.totalWeight.toString()+'g',
                            style: TextStyle(fontSize: 32))
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentPage()),
                    );
                  },
                  child: Text('Proceed'),
                ),
              ),
              Row(),
            ],
          )
        // ),
      );
  }
}