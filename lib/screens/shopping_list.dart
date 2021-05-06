import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/screens/adding_new_item.dart';
import 'package:selfcheckoutapp/models/todo.dart';
import 'package:selfcheckoutapp/widgets/list_checkbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  List<ToDo> list = <ToDo>[];
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    initSharedPreferences();
    super.initState();
  }

  initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
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
        child: list.isNotEmpty ? buildBody() : noContentScreen(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 130.0,
          right: 8.0,
        ),
        child: Container(
          height: 60.0,
          width: 60.0,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.add_rounded),
            onPressed: goToNewItemAdd,
          ),
        ),
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
    return Card(
      child: Dismissible(
        key: Key(item.hashCode.toString()), //HAS TO GIVE A UNIQUE KEY TO IDENTIFY THE DISMISS TILE
        onDismissed: (direction) => removeItem(item),
        direction: DismissDirection.startToEnd,
        background: Container(
          color: Color(0xffD50000),
          child: Icon(Icons.delete_rounded, color: Colors.white),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 15.0),
        ),
        child: GestureDetector(
          child: ListTile(
            title: Text(item.title),
            //leading: Checkbox(value: item.complete, onChanged: (value){item.complete = value;}),
            leading: CustomCheckbox(),
            //onTap: () => setComplete(item),
            onLongPress: () => goToEditItemView(item),
          ),
        ),
      ),
      elevation: 2.0,
    );
  }

  Container noContentScreen() {
    //final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Icon(
              Icons.close,
              size: 50.0,
              color: Colors.black26,
            ),
            Text(
              "No items added.\nPress the button to start!",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  // void setComplete(ToDo item) {
  //   setState(() {
  //     item.complete = !item.complete;
  //     saveDataList();
  //   });
  // }

  //FUNCTION TO REMOVE ITEMS FROM THE LIST
  void removeItem(ToDo item) {
    setState(() {
      list.remove(item);
      saveDataList();
    });
  }

  //ADDING NEW ITEMS TO LIST - NEW PAGE
  void goToNewItemAdd() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return NewItemView();
    })).then((title) {
      if (title != null) {
        addToDo(ToDo(title: title));
        saveDataList();
      }
    });
  }

  void addToDo(ToDo item) {
    setState(() {
      list.add(item);
      saveDataList();
    });
  }

  void goToEditItemView(ToDo item) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return NewItemView(
        title: item.title,
      );
    })).then((title) {
      if (title != null) {
        editToDo(item, title);
        saveDataList();
      }
    });
  }

  void editToDo(ToDo item, String title) {
    setState(() {
      item.title = title;
      saveDataList();
    });
  }

  void saveDataList() {
    List<String> spList =
        list.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('list', spList);
  }

  void loadData() {
    setState(() {
      List<String> spList = sharedPreferences.getStringList('list');
      list = spList.map((item) => ToDo.fromMap(json.decode(item))).toList();
    });
  }
}
