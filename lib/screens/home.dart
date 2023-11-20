// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:ak_password_manager/constants.dart';
import 'package:ak_password_manager/screens/add_password.dart';
import 'package:ak_password_manager/screens/login.dart';
import 'package:ak_password_manager/screens/settings.dart';
import 'package:ak_password_manager/utilities/password_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showSpinner = true;
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: kTextStyle,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              ListTile(
                title: Text(
                  'Home',
                  style: kTextStyle,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(
                  'Settings',
                  style: kTextStyle,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                },
              ),
              ListTile(
                title: Text(
                  'Log Out',
                  style: kTextStyle,
                ),
                onTap: () async {
                  await _firebaseAuth.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
              ),
            ],
          ).toList(),
        ),
      ),
      body: PasswordManager().getPasswords(userUid) ??
          const Center(
            child: Text(
              'There are no entries',
              style: TextStyle(
                color: Color(0xFFBDBDBD),
                fontSize: 20,
              ),
            ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddPassword(
                        appBarText: 'Add Password',
                      )));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.grey.shade700,
      ),
    );
  }
}
