import 'package:flutter/material.dart';

class Constants {
  static const appName = "Hayari";

  // colors 
  // light green: Color.fromARGB(255, 166, 191, 165)
  static const primaryAccentColor = Color.fromARGB(255, 166, 191, 165);
  static const secondaryAccentColor = Colors.black;
  static const greyAccentColor = Color(0xFFDCDCDC);

  // login page 
  static const customBtnColor = Colors.black; // fill color
  static const customBtnTextColorDark = Colors.black;
  static const customBtnTextColorLight = Colors.white;
  static const formBackgroundColor = Color(0xFFF2F2F2);
  static const backBtnColor = Colors.black;

  static const regularHeading = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,    
  );

  static const regularDarkText = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,    
  );

  static const boldHeading = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,    
  );
}