import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/widgets/bottom_tabs.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //CUSTOM HOME APP BAR
  Widget _homeAppBar() {
    return AppBar(
      title: Text(
        'Home',
        style: Constants.boldHeadingAppBar,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      leading: IconButton(
        icon: Icon(Icons.logout),
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image2.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: (Size(double.infinity, 200.0)),
        child: _homeAppBar(), // AppBar
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        // Container(
        //   child: Expanded(
        //     child: PageView(
        //       controller: _tabsPageController,
        //       onPageChanged: (num){
        //         setState(() {
        //           _selectedTab = num;
        //           print("Tab: ${_selectedTab}");
        //         });
        //       },
        //       children: [
        //         Container(
        //           child: Center(
        //               child: Text("Home")
        //           ),
        //         ),
        //         Container(
        //           child: Center(
        //               child: Text("2")
        //           ),
        //         ),
        //         Container(
        //           child: Center(
        //               child: Text("3")
        //           ),
        //         ),
        //         Container(
        //           child: Center(
        //               child: Text("4")
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        Container(
          child: Column(
            children: [
              Container(),
              Container(),
              Container(),
              Container(),
            ],
          ),
        ),
        BottomTabs(
          selectedTab: _selectedTab,
        ),
        ],
      ),
    );
  }
}
