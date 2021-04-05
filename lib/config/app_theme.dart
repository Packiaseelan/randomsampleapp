import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primaryColor = Color.fromARGB(255, 0, 163, 255);//(0xFF00A3FF);
  static const secondaryColor = Color(0xFF00A3FF);
  static const darkGray = Color(0xFF979797);
  static const grey = Color(0xFFACACAC);
  static const white = Color(0xFFFFFFFF);
  static const red = Color(0xFFDB3022);
  static const lightGray = Color(0xFF9B9B9B);
  static const orange = Color(0xFFFFBA49);
  static const background = Color.fromARGB(255, 46, 43, 95); //(0xFF464394);
  static const backgroundLight = Color.fromARGB(255, 61, 58, 106); //(0xFF3D3A6A);
  static const black = Color(0x00000000);
  static const success = Color(0xFF2AA952);
  static const disable = Color(0xFF929794);
  static const primaryTextColor = Color(0xFFFFFFFF);
  static const primaryTextColorLight = Color(0xFFF0F0F0);
  static const buttonColor = Color(0xFF626262);
  static const bgColor = Color.fromARGB(255, 36, 36, 36);

  static ThemeData of(context) {
    var theme = Theme.of(context);
    return theme.copyWith(

      primaryColor: primaryColor,
      primaryColorLight: lightGray,
      accentColor: secondaryColor,
      bottomAppBarColor: lightGray,
      backgroundColor: background,
      scaffoldBackgroundColor: background,
      errorColor: red,
      dividerColor: Colors.transparent,
      appBarTheme: theme.appBarTheme.copyWith(
        color: black,
        iconTheme: IconThemeData(color: primaryColor),
        textTheme: theme.textTheme.copyWith(
          caption: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: primaryTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
        ),
      ),
      textTheme: theme.textTheme
          .copyWith(
            headline1: TextStyle(
              color: primaryTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
            headline2: TextStyle(
              color: primaryTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
            headline3: TextStyle(
              color: primaryTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            headline5: TextStyle(
              color: primaryTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            headline6: TextStyle(
              color: primaryTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            subtitle1: TextStyle(
              color: primaryTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            subtitle2: TextStyle(
              color: primaryTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            bodyText1: TextStyle(
              color: primaryTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            bodyText2: TextStyle(
              color: primaryTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
            button: TextStyle(
              color: primaryTextColor,
              letterSpacing: 1.7,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            caption: TextStyle(
              color: primaryTextColor.withOpacity(0.70),
              fontWeight: FontWeight.w400,
              fontSize: 10,
            )
          )
          .apply(
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
      buttonTheme: theme.buttonTheme.copyWith(
        minWidth: 50,
        buttonColor: primaryColor,
      ),
    );
  }
}
