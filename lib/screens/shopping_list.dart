import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/screens/adding_new_item.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class ToDo {
  String title;
  bool complete = false;

  ToDo({this.title, this.complete});
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  List<ToDo> list = List<ToDo>();

  void setComplete(ToDo item) {
    setState(() {
      item.complete = !item.complete;
    });
  }

  //FUNCTION TO REMOVE ITEMS FROM THE LIST
  void removeItem(ToDo item) {
    list.remove(item);
  }

  //ADDING NEW ITEMS TO LIST - NEW PAGE
  void goToNewItemAdd() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return NewItemView();
    }));
  }

  @override
  void initState() {
    list.add(ToDo(title: "Item 1"));
    list.add(ToDo(title: "Item 2"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shopping List",
          style: Constants.boldHeadingAppBar,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      body: SafeArea(
        child: buildBody(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add_rounded),
        onPressed: () => goToNewItemAdd(),
      ),
    );
  }

  Widget buildBody() {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return buildItem(list[index]);
      },
    );
  }

  Widget buildItem(ToDo item) {
    return Dismissible(
      key: Key(item.hashCode.toString()),
      //HAS TO GIVE A UNIQUE KEY TO IDENTIFY THE DISMISS TILE
      onDismissed: (direction) => removeItem(item),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Color(0xffD50000),
        child: Icon(Icons.delete_rounded, color: Colors.white),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 15.0),
      ),
      child: ListTile(
        title: Text(item.title),
        leading:
            Checkbox(value: item.complete, onChanged: null, tristate: true),
        onTap: () => setComplete(item),
      ),
    );
  }
}
