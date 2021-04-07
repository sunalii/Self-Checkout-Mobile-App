import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/screens/bill_history.dart';
import 'package:selfcheckoutapp/screens/shopping_cart.dart';
import 'package:selfcheckoutapp/screens/shopping_list.dart';
import 'package:selfcheckoutapp/widgets/bottom_tabs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //CUSTOM HOME APP BAR
  Widget _homeAppBar() {
    return Scaffold(
        // appBar: AppBar(
        //     title: Text(
        //       'Home',
        //       style: Constants.boldHeadingAppBar,
        //     ),
        //     textTheme: GoogleFonts.poppinsTextTheme(),
        //     // leading: IconButton(
        //     //   icon: Icon(Icons.logout),
        //     //   onPressed: () {
        //     //     FirebaseAuth.instance.signOut();
        //     //   },
        //     // ),
        //     flexibleSpace: Container(
        //       decoration: BoxDecoration(
        //         image: DecorationImage(
        //           image: AssetImage("assets/image2.png"),
        //           fit: BoxFit.cover,
        //         ),
        //       ),
        //     ),
        //   ),
        //   //preferredSize: Size.fromHeight(200.0),
        //
        // drawer: Drawer(
        //   child: ListView(
        //     children: [
        //       DrawerHeader(child: Text("ScanGo")),
        //     ],
        //   ),
        // ),
        );
  }

  // PageController _tabsPageController;
  // int _selectedTab = 0;
  //
  // @override
  // void initState() {
  //   _tabsPageController = PageController();
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   _tabsPageController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: Constants.boldHeadingAppBar,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      //preferredSize: Size.fromHeight(200.0),

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
                      color: new Color(0xFF0062ac),
                      image: DecorationImage(
                          image: AssetImage("assets/image2.png"),
                          fit: BoxFit.cover),
                    ),
                    accountName: Text(
                      "User Name",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    accountEmail: Text("user@email.com"),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    title: Text("Welcome to ScanGo",
                        style: TextStyle(fontSize: 20.0)),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShoppingListPage()),
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
                            builder: (context) => ShoppingListPage()),
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
              child: ListTile(
                dense: true,
                title: Text("Logout", style: Constants.regularDarkText),
                trailing: Text(
                  "Version 1.0",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                leading: IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //   Container(
      //     child: Expanded(
      //       child: PageView(
      //         controller: _tabsPageController,
      //         onPageChanged: (num){
      //           setState(() {
      //             _selectedTab = num;
      //             print("Tab: ${_selectedTab}");
      //           });
      //         },
      //         children: [
      //           Container(
      //             child: Center(
      //                 child: Text("Home")
      //             ),
      //           ),
      //           Container(
      //             child: Center(
      //                 child: Text("2")
      //             ),
      //           ),
      //           Container(
      //             child: Center(
      //                 child: Text("3")
      //             ),
      //           ),
      //           Container(
      //             child: Center(
      //                 child: Text("4")
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      //
      //   BottomTabs(
      //     selectedTab: _selectedTab,
      //   ),
      //   ],
      // ),

      /*body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: 30.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20.0
                ),
                child: Text(
                  "What do you want to do?",
                  textAlign: TextAlign.left,
                  style: Constants.boldHeading,
                ),
              ),
              HomeNavigateTabs(
                text: "Create a Shopping List",
                iconData: Icons.assignment_turned_in_rounded,
                onPressed: (){
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShoppingListPage()),
                    );
                  });
                },
              ),
              HomeNavigateTabs(
                text: "Check Bill History",
                iconData: Icons.history,
                onPressed: (){
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BillHistoryPage()),
                    );
                  });
                },
              ),
              HomeNavigateTabs(
                text: "Let's Start Shopping!",
                iconData: Icons.shopping_cart_rounded,
                onPressed: (){
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShoppingCartPage()),
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),*/

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
