import 'package:ak_password_manager/widgets/textbar.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class MyForm {
  List<Widget> getFormForSignin(errormessage, emailController,
      passwordController, buttonName, Widget textbutton,
      {required onPressed}) {
    return [
      const SizedBox(
        height: 30,
      ),
      const Text(
        'Welcome',
        style: kTextStyle,
      ),
      const SizedBox(
        height: 60,
      ),
      TextBar(
          labelText: 'Email',
          hintText: 'Enter your Username',
          obsecureText: false,
          controller: emailController,
          emailAddress: true),
      const SizedBox(
        height: 30,
      ),
      TextBar(
          labelText: 'Password',
          hintText: 'Enter your Password',
          obsecureText: true,
          controller: passwordController,
          emailAddress: false),
      const SizedBox(
        height: 15,
      ),
      checkErrorMessage(errormessage) ? errormessage : const SizedBox(height: 0,),
      checkErrorMessage(errormessage) ? const SizedBox(height: 15,) : const SizedBox(height: 0,),
      RaisedButton(
        onPressed: onPressed,
        child: Text(
          buttonName,
          textScaleFactor: 2,
        ),
        color: Colors.grey.shade800,
      ),
      const SizedBox(
        height: 20,
      ),
      textbutton,
    ];
  }

  checkErrorMessage(errorMessage) {
    if (errorMessage !=
        const Text('',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ))) {
      return true;
    } else {
      return false;
    }
  }
}
