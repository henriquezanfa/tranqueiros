// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Theme app theme class.
class TranqueirosAppTheme {
  /// The app theme
  static ThemeData get theme => ThemeData(
        primaryColor: colors.primary,
        textTheme: GoogleFonts.montserratTextTheme(),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: colors.accent),
        scaffoldBackgroundColor: colors.primary,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(double.infinity, 40),
            ),
            backgroundColor: MaterialStateProperty.all(colors.accent),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      );

  /// The app colors.
  static TranqueirosColors get colors => TranqueirosColors();
}

/// The app colors.
class TranqueirosColors {
  final primary = const Color.fromRGBO(0x3C, 0x88, 0x11, 1);
  final secondary = const Color.fromRGBO(0x2A, 0x60, 0x0B, 1);
  final accent = const Color.fromRGBO(0x88, 0x11, 0x11, 1);
}
