import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:selfcheckoutapp/screens/bill_history.dart';
import 'package:selfcheckoutapp/screens/home.dart';
import 'package:selfcheckoutapp/screens/shopping_cart.dart';
import 'package:selfcheckoutapp/screens/shopping_list.dart';

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
              if(_selectedTab != 0){
                setState(() {
                  _selectedTab = 0;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                });
              }
            },
          ),
          BottomTabBtn(
            iconData: Icons.assignment_turned_in_rounded,
            selected: _selectedTab == 1 ? true : false,
            onPressed: (){
              if(_selectedTab != 1){
                setState(() {
                  _selectedTab = 1;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShoppingListPage()),
                  );
                });
              }
            },
          ),
          BottomTabBtn(
            iconData: Icons.history,
            selected: _selectedTab == 2 ? true : false,
            onPressed: (){
              if(_selectedTab != 2){
                setState(() {
                  _selectedTab = 2;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BillHistoryPage()),
                  );
                });
              }
            },
          ),
          BottomTabBtn(
            iconData: Icons.shopping_cart_rounded,
            selected: _selectedTab == 3 ? true : false,
            onPressed: (){
              if(_selectedTab != 3){
                setState(() {
                  _selectedTab = 3;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShoppingCartPage()),
                  );
                });
              }
            },
          ),
        ],
      )
    );
  }
}

//BOTTOM NAVIGATION BAR BUTTON - INCLUDED IN ButtomTabs CLASS
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
  final Function onPressed;

  const HomeNavigateTabs({Key key, this.text, this.iconData, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
        child: Container(
          child: Row(
              children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
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
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 30.0,
                        right: 10.0
                      ),
                      child: Text(text ?? "Text",
                      textAlign: TextAlign.left,
                      style: Constants.regularHeading,),
                    ),
                  ),
              ],
            ),
          //CONTAINER CONTINUED
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
            ],
          ),
          margin: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
        ),
    );
  }
}



//CHECKOUT TAB FOR SHOPPING CART PAGE
class CartBottomTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          CartBottomTabBtn(),
          CartBottomTabTotal(),
        ],
      ),
    );
  }
}

class CartBottomTabBtn extends StatelessWidget {

  final Function onPressed;

  const CartBottomTabBtn({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60.0,
        width: 150.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xffD50000),
          border: Border.all(
            color: Color(0xffD50000),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 30.0,
        ),
        child: Text("Check Out",
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}


class CartBottomTabTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 30.0,
      ),
      child: Column(
        children: [
          Text("Total",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
          Text("LKR 300",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}








