import 'package:flutter/material.dart';
import 'package:mad_project/constants.dart';

class CustomFormInput extends StatelessWidget {
  final String? hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction?
      textInputAction; // to show next button on keyboard (bottom right) when entering field value (enchances UX)
  final bool? isPasswordField;

  const CustomFormInput(
      {Key? key,
      this.hintText,
      this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.textInputAction,
      this.isPasswordField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isPasswordField =
        isPasswordField ?? false; // if null, set to false by default

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      decoration: const BoxDecoration(
        color: Constants.formBackgroundColor,
        //  borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        obscureText: _isPasswordField,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.7),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Constants.customBtnColor, width: 1.0)
            ),
            hintText: hintText ?? "Hint text...",
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 14.0,
            )),
        style: Constants.regularDarkText,
      ),
    );
  }
}
