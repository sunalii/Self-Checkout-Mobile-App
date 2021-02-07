import 'package:flutter/material.dart';
import 'package:selfcheckoutapp/screens/bill_history.dart';
import 'package:selfcheckoutapp/screens/home.dart';
import 'package:selfcheckoutapp/screens/shopping_cart.dart';
import 'package:selfcheckoutapp/screens/shopping_list.dart';

class BottomTabsPage extends StatefulWidget {
  @override
  _BottomTabsPageState createState() => _BottomTabsPageState();
}

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
];*/

class _BottomTabsPageState extends State<BottomTabsPage> {
  /*PageController _pageController = PageController();
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
  }*/

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
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
    );*/

    return Scaffold(
    );
  }
}
