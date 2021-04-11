import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/screens/bill_history.dart';
import 'package:selfcheckoutapp/screens/edit_user_profile.dart';
import 'package:selfcheckoutapp/screens/shopping_cart.dart';
import 'package:selfcheckoutapp/screens/shopping_list.dart';
import 'package:selfcheckoutapp/widgets/bottom_tabs.dart';
import 'package:selfcheckoutapp/widgets/custom_button.dart';
import 'package:selfcheckoutapp/widgets/profile_avatar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Home',
          style: Constants.boldHeadingAppBar,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        toolbarHeight: 200.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              image: DecorationImage(
                  image: AssetImage("assets/image2.png"),
                  fit: BoxFit.cover
              )
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Color(0xffD50000),
                      image: DecorationImage(
                          image: AssetImage("assets/image2.png"),
                          fit: BoxFit.cover),
                    ),
                    accountName: Text(
                      "${FirebaseAuth.instance.currentUser.displayName}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    accountEmail: Text('${FirebaseAuth.instance.currentUser.email}'),
                    currentAccountPicture: Avatar(),
                  ),
                  ListTile(
                    dense: true,
                    title: Text(
                      "Welcome to ScanGo",
                      style:
                          TextStyle(fontSize: 20.0, color: Color(0xff110000)),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditUserProfile()),
                      );
                    },
                    dense: true,
                    title: Text("Account Settings",
                        style: Constants.regularDarkText),
                    leading: Icon(Icons.account_circle),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage()),
                      );
                    },
                    dense: true,
                    title: Text("About App", style: Constants.regularDarkText),
                    leading: Icon(Icons.info),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    dense: true,
                    title: Text("Close", style: Constants.regularDarkText),
                    leading: Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: CustomBtn(
                text: "Logout",
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                outlineBtn: true,
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: 30.0,
                  left: 30.0,
                ),
                margin: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "What do you want to do?",
                  textAlign: TextAlign.left,
                  style: Constants.boldHeading,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    HomeNavigateTabs(
                      text: "Create a Shopping List",
                      iconData: Icons.assignment_turned_in_rounded,
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShoppingListPage()),
                          );
                        });
                      },
                    ),
                    HomeNavigateTabs(
                      text: "Check Bill History",
                      iconData: Icons.history,
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BillHistoryPage()),
                          );
                        });
                      },
                    ),
                    HomeNavigateTabs(
                      text: "Let's Start Shopping!",
                      iconData: Icons.shopping_cart_rounded,
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShoppingCartPage()),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
