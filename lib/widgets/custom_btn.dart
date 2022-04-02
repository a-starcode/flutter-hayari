import 'package:flutter/material.dart';
import 'package:mad_project/constants.dart';

class CustomBtn extends StatelessWidget {
  final String? btnText;
  // just a Function but it can accept void as return value
  final VoidCallback? onPressed;
  // if true, button will have no fill (transparent), only a border with text inside
  final bool? outlineBtn;
  final Color btnColor;
  final bool? isLoading;

  const CustomBtn({
    Key? key,
    this.btnText,
    this.onPressed,
    required this.btnColor,
    this.outlineBtn,
    this.isLoading, // will not have a fill color, just the outline
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // local variables to handle final variables
    bool _outlineBtn = outlineBtn ?? false;
    bool _isLoading = isLoading ?? false;

    return GestureDetector(
      // GestureDectector will constantly monitor for taps on the button
      onTap: onPressed, // if a tap is detected, function onPressed() is called
      // could use a Button widget here as well, but Containers are easy to style and work with, doesn't really matter
      child: Container(
          height: 55.0,
          decoration: BoxDecoration(
            color: _outlineBtn ? Colors.transparent : btnColor,
            border: Border.all(
              color: btnColor,
              width: 2.0,
            ),
            // borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 8.0,
          ),
          child: Stack(
            children: [
              Visibility(
                visible: _isLoading ? false : true,
                child: Center(
                  child: Text(
                    btnText ?? "Text",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: _outlineBtn
                          ? Constants.customBtnTextColorDark
                          : Constants.customBtnTextColorLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Visibility(
                child: Center(
                  child: SizedBox(
                    height: 30.0,
                    width: 30.0,
                    // child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
