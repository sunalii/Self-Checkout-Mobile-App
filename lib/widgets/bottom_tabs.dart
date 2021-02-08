import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
// import 'package:selfcheckoutapp/screens/bill_history.dart';
// import 'package:selfcheckoutapp/screens/home.dart';
// import 'package:selfcheckoutapp/screens/shopping_cart.dart';
// import 'package:selfcheckoutapp/screens/shopping_list.dart';

/*class BottomTabsPage extends StatefulWidget {
  @override
  _BottomTabsPageState createState() => _BottomTabsPageState();
}*/ //TRY2

//ITEMS IN BOTTOM TAB
/*List<TabNavigationItem> get items => [
  TabNavigationItem(
      page: HomePage(),
      title: "Home",
      icon: Icon(Icons.home_rounded)
  ),
  TabNavigationItem(
      page: ShoppingListPage(),
      title: "Shopping List",
      icon: Icon(Icons.assignment_turned_in_rounded)
  ),
  TabNavigationItem(
      page: ShoppingCartPage(),
      title: "Cart",
      icon: Icon(Icons.shopping_cart_rounded)
  ),
  TabNavigationItem(
      page: BillHistoryPage(),
      title: "Bill History",
      icon: Icon(Icons.history)
  ),
];*/ //TRY1

/*class _BottomTabsPageState extends State<BottomTabsPage> {
  PageController _pageController = PageController();
  List<Widget> _screens = [
    HomePage(),
    ShoppingListPage(),
    ShoppingCartPage(),
    BillHistoryPage(),

  ];

  int _selectedIndex = 0;
  void _onPageChanged(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex){
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
              color: _selectedIndex == 0 ? Colors.green : Colors.grey,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in_rounded),
            label: "Shopping List",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Bill History",
          ),
        ],
      ),
    );
  }
}*/ //TRY2


class BottomTabs extends StatefulWidget {
  final int selectedTab;
  const BottomTabs({Key key, this.selectedTab}) : super(key: key);

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1.0,
            blurRadius: 30.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabBtn(
            iconData: Icons.home_rounded,
            selected: _selectedTab == 0 ? true : false,
            onPressed: (){
              setState(() {
                _selectedTab = 0;
              });
            },
          ),
          BottomTabBtn(
            iconData: Icons.assignment_turned_in_rounded,
            selected: _selectedTab == 1 ? true : false,
            onPressed: (){
              setState(() {
                _selectedTab = 1;
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ShoppingListPage()),
                // );
              });
            },
          ),
          BottomTabBtn(
            iconData: Icons.shopping_cart_rounded,
            selected: _selectedTab == 2 ? true : false,
            onPressed: (){
              setState(() {
                _selectedTab = 2;
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ShoppingCartPage()),
                // );
              });
            },
          ),
          BottomTabBtn(
            iconData: Icons.history,
            selected: _selectedTab == 3 ? true : false,
            onPressed: (){
              setState(() {
                _selectedTab = 3;
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => BillHistoryPage()),
                // );
              });
            },
          ),
        ],
      )
    );
  }
}

class BottomTabBtn extends StatelessWidget {

  final IconData iconData; //CUSTOM ICON
  final String icon;
  final bool selected;
  final Function onPressed;

  const BottomTabBtn({Key key, this.icon, this.selected, this.iconData, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //CHECKING WHETHER THE TAB IS SELECTED
    bool _selected = selected ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 28.0,
          horizontal: 16.0
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: _selected ? Theme.of(context).accentColor : Colors.transparent,
              width: 2.0
            )
          )
        ),
        child: Icon(
          iconData ?? Icons.home_rounded,
          color: _selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}

//HOME NAVIGATION TABS
class HomeNavigateTabs extends StatelessWidget {

  final String text;
  final IconData iconData;

  const HomeNavigateTabs({Key key, this.text, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: Container(
        child: Row(
          children: [
            Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    spreadRadius: 1.0,
                    blurRadius: 30.0,
                  ),
                ],
              ),
              child: Icon(
                iconData ?? Icons.home_rounded,
                color: Theme.of(context).accentColor,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 30.0,
              ),
              child: Text(text ?? "Text",
              textAlign: TextAlign.center,
              style: Constants.regularHeading,),
              ),
          ],
        ),
        height: 60.0,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xff1faa00),
            width: 0.2,
          ),
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              spreadRadius: 1.0,
              blurRadius: 30.0,
            ),
          ]
        ),
        margin: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 8.0,
        ),
      ),
    );
  }
}








