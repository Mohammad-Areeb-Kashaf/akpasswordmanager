// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:ak_password_manager/constants.dart';
import 'package:ak_password_manager/screens/login.dart';
import 'package:ak_password_manager/widgets/textbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String errorMessage = '';
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  var result;
  var authenticateButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                'Change Password',
                style: kTextStyle,
              ),
              const SizedBox(
                height: 30,
              ),
              TextBar(
                  labelText: 'New Password',
                  hintText: 'Enter your new password',
                  obsecureText: true,
                  controller: newPasswordController,
                  emailAddress: false),
              const SizedBox(
                height: 30,
              ),
              TextBar(
                  labelText: 'Confirm Password',
                  hintText: 'Cofirm your new password',
                  obsecureText: true,
                  controller: confirmNewPasswordController,
                  emailAddress: false),
              const SizedBox(
                height: 30,
              ),
              Text(
                errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                onPressed: () {
                  if (newPasswordController.text.length >= 6) {
                    if (newPasswordController.text ==
                        confirmNewPasswordController.text) {
                      _changePassword();
                    } else {
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            content: Text('Please check the passwords')));
                    }
                  } else {
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                          content: Text('Please check the passwords')));
                  }
                },
                color: Colors.grey.shade800,
                child: Text(
                  'Change Password',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () async {
                  result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(
                          loginForApp: false,
                        ),
                      ));
                },
                child: Text('authenticate now'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _changePassword() async {
    var user = FirebaseAuth.instance.currentUser;
    String oldPassword = oldPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmNewPassword = confirmNewPasswordController.text;
    try {
      print(result.toString());
      if (result.toString() == 'Success') {
        user?.updatePassword(newPassword).then((_) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(
                'Successfully changed password',
              ),
              backgroundColor: Colors.grey.shade700,
            ));
        }).catchError((error) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text("Password can't be changed$error"),
              backgroundColor: Colors.grey.shade700,
            ));
        });
      } else {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text('Seems like you have not authenticated'),
            backgroundColor: Colors.grey.shade700,
          ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text('Something went wrong please try again later'),
          backgroundColor: Colors.grey.shade700,
        ));
    }
  }
}
