import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/screens/home.dart';
import 'package:selfcheckoutapp/widgets/custom_button.dart';
import 'package:selfcheckoutapp/widgets/custom_input.dart';
import '../constants.dart';

class EditUserProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: Constants.boldHeadingAppBar,
        ),
        leading: Icon(Icons.edit),
        textTheme: GoogleFonts.poppinsTextTheme(),
        backgroundColor: Colors.blue,
        toolbarHeight: 80.0,
        elevation: 0.0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blue,
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
                  child: SizedBox(
                    height: 115,
                    width: 115,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/image2.png"),
                        ),
                        Positioned(
                          right: -10,
                          bottom: 0,
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: Color(0xfff5f6f9)),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Color(0xff9a9a9c),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Divider(),
                SizedBox(
                  height: 10.0,
                ),
                CustomInput(
                  hintText: "Edit Display Name...",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomEditBtn(
                      text: "Cancel",
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.pop(context);
                      },
                      outlineBtn: true,
                    ),
                    CustomEditBtn(
                      text: "Save",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
