import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewItemView extends StatefulWidget {
  final String title;

  const NewItemView({Key key, this.title}) : super(key: key);

  @override
  _NewItemViewState createState() => _NewItemViewState();
}

class _NewItemViewState extends State<NewItemView> {
  TextEditingController textFieldController;

  @override
  void initState() {
    textFieldController = TextEditingController(text: widget.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Colors.blue,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 15.0),
              child: IconButton(
                icon: Icon(Icons.close_rounded, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 130.0,
                bottom: 150.0,
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25.0),
                height: 150.0,
                alignment: Alignment.center,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        left: 10.0,
                        right: 10.0,
                      ),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                          hintText: "New Item",
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          contentPadding: EdgeInsets.only(top: 18.0),
                        ),
                        controller: textFieldController,
                        onEditingComplete: () => saveData(),
                        autofocus: true,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          saveData();
                        });
                      },
                      child: Text(
                        "ADD",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveData() {
    if (textFieldController.text.isNotEmpty) {
      setState(() {
        Navigator.of(context).pop(textFieldController.text);
      });
    }
  }
}
