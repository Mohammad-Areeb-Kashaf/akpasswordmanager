import 'package:flutter/material.dart';

TextButton MyTextButton({
  required text,
  required Function onPressed,
}) {
  return TextButton(
    onPressed: onPressed(),
    child: Text(
      text,
      style: TextStyle(
        decoration: TextDecoration.underline,
        fontStyle: FontStyle.normal,
        color: Colors.grey.shade400,
      ),
    ),
  );
}
