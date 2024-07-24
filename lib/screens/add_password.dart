// ignore_for_file: prefer_const_constructors

import 'package:ak_password_manager/screens/showads.dart';
import 'package:ak_password_manager/utilities/password_manager.dart';
import 'package:ak_password_manager/widgets/textbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AddPassword extends StatefulWidget {
  final appBarText;
  final userUid;
  final email;
  final password;
  final label;
  final username;
  final note;
  final id;
  const AddPassword({
    Key? key,
    this.appBarText,
    this.userUid,
    this.label,
    this.username,
    this.email,
    this.password,
    this.note,
    this.id,
  }) : super(key: key);

  @override
  _AddPasswordState createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {
  final addLabelController = TextEditingController();
  final addUsernameController = TextEditingController();
  final addEmailController = TextEditingController();
  final addPasswordController = TextEditingController();
  final addNoteController = TextEditingController();
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  final userEmail = FirebaseAuth.instance.currentUser!.email;
  bool isLoading = false;
  var errorMessage = '';

  @override
  void initState() {
    super.initState();
    addLabelController.text = widget.label ?? '';
    addUsernameController.text = widget.username ?? '';
    addEmailController.text = widget.email ?? '';
    addPasswordController.text = widget.password ?? '';
    addNoteController.text = widget.note ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.appBarText,
          style: kTextStyle,
        ),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextBar(
                  labelText: 'Label',
                  hintText: 'Enter label name',
                  obsecureText: false,
                  controller: addLabelController,
                  emailAddress: false),
              const SizedBox(
                height: 30,
              ),
              TextBar(
                  labelText: 'Username',
                  hintText: 'Enter your Username',
                  obsecureText: false,
                  controller: addUsernameController,
                  emailAddress: false),
              const SizedBox(
                height: 30,
              ),
              TextBar(
                  labelText: 'Email',
                  hintText: 'Enter your Email address',
                  obsecureText: false,
                  controller: addEmailController,
                  emailAddress: true),
              const SizedBox(
                height: 30,
              ),
              TextBar(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  obsecureText: true,
                  controller: addPasswordController,
                  emailAddress: false),
              const SizedBox(
                height: 30,
              ),
              TextBar(
                  labelText: 'Note',
                  hintText:
                      'Enter your note which will be saved with the password',
                  obsecureText: false,
                  controller: addNoteController,
                  emailAddress: false,
                  isNote: true),
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
                onPressed: () async {
                  if (addLabelController.text.isEmpty) {
                    setState(() {
                      errorMessage = 'Label should not be empty';
                    });
                  } else if (addEmailController.text.isEmpty) {
                    setState(() {
                      errorMessage = 'Email should not be empty';
                    });
                  } else {
                    setState(() {
                      isLoading = true;
                    });
                    PasswordManager().setPassword(
                        userUid,
                        addLabelController.text,
                        addUsernameController.text,
                        addEmailController.text,
                        addPasswordController.text,
                        userEmail,
                        addNoteController.text);
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowRewardedAds()));
                  }
                },
                color: Colors.grey.shade800,
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 24),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
