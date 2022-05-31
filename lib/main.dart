import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tranqueiros/core/consts.dart';
import 'package:tranqueiros/feature/dashboard/presentation/ui/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tranqueiros',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: verde,
        textTheme: GoogleFonts.montserratTextTheme(),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: vinho),
      ),
      home: const DashboardScreen(title: 'Tranqueiros'),
    );
  }
}
