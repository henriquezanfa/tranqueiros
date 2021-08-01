import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/consts.dart';
import 'feature/dashboard/presentation/ui/dashboard_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tranqueiros',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: vinho,
        primaryColor: verde,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: DashboardScreen(title: 'Tranqueiros'),
    );
  }
}
