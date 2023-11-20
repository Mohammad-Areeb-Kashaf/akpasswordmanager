import 'package:ak_password_manager/constants.dart';
import 'package:flutter/material.dart';

TextField TextBar ({required String labelText, String? hintText, bool? obsecureText, TextEditingController? controller, bool? emailAddress, bool? isEnabled, bool? isNote}) {
  return TextField(
    style: kTextStyleForTextField,
    controller: controller,
    keyboardType: emailAddress ?? false ? TextInputType.emailAddress : null,
    obscureText: obsecureText ?? false,
    maxLines: isNote ?? false ? 3 : 1,
    decoration: InputDecoration(
      enabledBorder: kBorderStyle,
      border: kBorderStyle,
      focusedBorder: kBorderStyle,
      hintText: hintText,
      hintStyle: kTextStyleForTextField,
      labelText: labelText,
      labelStyle: kTextStyleForTextField,
    ),
    cursorColor: Colors.grey.shade400,
    enabled: isEnabled ?? true,
  );
}
