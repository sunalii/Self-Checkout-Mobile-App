import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/screens/edit_user_profile.dart';
import 'package:selfcheckoutapp/widgets/custom_button.dart';
import 'package:selfcheckoutapp/widgets/profile_avatar.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('UserDetails')
                        .doc('displayName')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text("Display Name");
                      } else {
                        return UserAccountsDrawerHeader(
                          decoration: BoxDecoration(
                            color: Color(0xffD50000),
                            image: DecorationImage(
                                image: AssetImage("assets/image2-dark.png"),
                                fit: BoxFit.cover),
                          ),
                          accountName: StreamBuilder<Object>(
                              stream: null,
                              builder: (context, snapshot) {
                                return Text(
                                  "${FirebaseAuth.instance.currentUser.displayName}",
                                  style: TextStyle(fontSize: 20.0),
                                );
                              }),
                          accountEmail: Text(
                              '${FirebaseAuth.instance.currentUser.email}'),
                          currentAccountPicture: Avatar(),
                        );
                      }
                    }),
                ListTile(
                  dense: true,
                  title: Text(
                    "Welcome to ScanGo",
                    style: TextStyle(fontSize: 20.0, color: Color(0xff062100)),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditUserProfile()),
                    );
                  },
                  dense: true,
                  title: Text("Profile", style: Constants.regularDarkText),
                  leading: Icon(
                    Icons.account_circle,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ListTile(
                  onTap: () {
                    showAboutDialog(
                        context: context,
                        applicationName: 'ScanGo',
                        applicationVersion: 'Version 1.0',
                        applicationLegalese:
                            'ScanGo is a Self-Checkout Mobile Application.\n\n'
                            'Scan->Add->Check->Pay->Go');
                  },
                  dense: true,
                  title: Text("About App", style: Constants.regularDarkText),
                  leading: Icon(
                    Icons.info,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  dense: true,
                  title: Text("Close", style: Constants.regularDarkText),
                  leading: Icon(
                    Icons.close_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: CustomBtn(
              text: "Logout",
              onPressed: () {
                confirmationAlert(context);
                // setState(() {
                //   confirmationAlert(context);
                // });
              },
              outlineBtn: true,
            ),
          ),
        ],
      ),
    );
  }
}

confirmationAlert(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
            title: Text("Logout?"),
            content: Text("Do you want to Logout?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No"),
              ),
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Text("Yes"),
              )
            ],
          ));
}
