import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/widgets/bottom_tabs.dart';
import 'package:selfcheckoutapp/widgets/custom_button.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {

  List<ToDo> list = List<ToDo>();


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
        title: Text("Shopping List",
        style: Constants.boldHeadingAppBar,
        ),
          textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(list[index].title),
            leading: Icon(Icons.check_box),
            onTap: () => setComplete(list[index]),
          );
        },
      ),
    );
  }
}

void setComplete(ToDo item){
  
}

class ToDo{
  String title;
  bool complete = false;

  ToDo({this.title, this.complete});
}