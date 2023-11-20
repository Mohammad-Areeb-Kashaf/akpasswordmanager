// ignore_for_file: prefer_const_constructors

import 'package:ak_password_manager/constants.dart';
import 'package:ak_password_manager/screens/change_password.dart';
import 'package:ak_password_manager/screens/login.dart';
import 'package:ak_password_manager/widgets/textbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: kTextStyle,),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Change Password'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()));
            },
          )
        ],
      ),
    );
  }
}
