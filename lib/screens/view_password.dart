import 'package:ak_password_manager/utilities/password_manager.dart';
import 'package:ak_password_manager/widgets/textbar.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class ViewPassword extends StatefulWidget {
  ViewPassword(
      {this.label,
      this.username,
      this.email,
      this.password,
      this.note,
      this.id,
      this.userUid,
      this.labelController,
      this.emailController,
      this.usernameController,
      this.passwordController,
      this.noteController});
  final password;
  final email;
  final note;
  final username;
  var label;
  final id;
  final userUid;
  final labelController;
  final emailController;
  final usernameController;
  final passwordController;
  final noteController;
  late var isEnabled = false;

  @override
  State<ViewPassword> createState() => _ViewPasswordState();
}

class _ViewPasswordState extends State<ViewPassword> {
  @override
  void initState() {
    super.initState();
    widget.labelController.text = widget.label;
    widget.usernameController.text = widget.username;
    widget.emailController.text = widget.email;
    widget.passwordController.text = widget.password;
    widget.noteController.text = widget.note;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.label,
          style: kTextStyle,
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: const Text('Delete'),
                  onTap: () {
                    PasswordManager()
                        .deletePassword(id: widget.id, userUid: widget.userUid);
                    Navigator.of(context).pop();
                  },
                ),
                PopupMenuItem(
                  child: const Text('Update'),
                  onTap: () {
                    setState(() {
                      widget.isEnabled = true;
                    });
                  },
                )
              ];
            },
            child: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            showTextBar(widget.label)
                ? TextBar(
                    labelText: 'Label',
                    controller: widget.labelController,
                    isEnabled: widget.isEnabled)
                : const SizedBox(
                    height: 0,
                  ),
            const SizedBox(
              height: 30,
            ),
            showTextBar(widget.username)
                ? TextBar(
                    labelText: 'Username',
                    controller: widget.usernameController,
                    isEnabled: widget.isEnabled)
                : const SizedBox(
                    height: 0,
                  ),
            const SizedBox(
              height: 30,
            ),
            showTextBar(widget.email)
                ? TextBar(
                    labelText: 'Email',
                    controller: widget.emailController,
                    isEnabled: widget.isEnabled)
                : const SizedBox(
                    height: 0,
                  ),
            const SizedBox(
              height: 30,
            ),
            showTextBar(widget.password)
                ? TextBar(
                    labelText: 'Password',
                    controller: widget.passwordController,
                    isEnabled: widget.isEnabled)
                : const SizedBox(
                    height: 0,
                  ),
            const SizedBox(
              height: 30,
            ),
            showTextBar(widget.note)
                ? TextBar(
                    labelText: 'Note',
                    controller: widget.noteController,
                    isEnabled: widget.isEnabled,
                    isNote: true)
                : const SizedBox(
                    height: 0,
                  ),
            showTextBar(widget.note)
                ? const SizedBox(
                    height: 30,
                  )
                : const SizedBox(
                    height: 0,
                  ),
            widget.isEnabled
                ? RaisedButton(
                    onPressed: () {
                      PasswordManager().updatePassword(
                          label: widget.labelController.text,
                          username: widget.usernameController.text,
                          email: widget.emailController.text,
                          password: widget.passwordController.text,
                          note: widget.noteController.text,
                          id: widget.id,
                          userUid: widget.userUid);
                      setState(() {
                        widget.isEnabled = false;
                        widget.label = widget.labelController.text;
                      });
                    },
                    child: const Text(
                      'Update',
                      textScaleFactor: 2,
                    ),
                    color: Colors.grey.shade800,
                  )
                : const SizedBox(
                    height: 0,
                  )
          ],
        ),
      ),
    );
  }

  showTextBar(textBarText) {
    if (textBarText != 'null') {
      return true;
    } else {
      return false;
    }
  }
}
