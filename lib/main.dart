// ignore_for_file: prefer_const_constructors

import 'package:ak_password_manager/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp();
  runApp(const AKPasswordManager());
}

class AKPasswordManager extends StatelessWidget {
  const AKPasswordManager({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return MaterialApp(
      title: 'AK Password Manager',
      home: Login(loginForApp: true,),
      theme: ThemeData.dark().copyWith(
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: Colors.grey.shade700,
          )
      ),
      themeMode: ThemeMode.dark,
    );
  }
}

