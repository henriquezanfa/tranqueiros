import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tranqueiros/core/consts.dart';
import 'package:tranqueiros/feature/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:tranqueiros/feature/home/home_screen.dart';

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
        scaffoldBackgroundColor: verde,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(double.infinity, 40),
            ),
            backgroundColor: MaterialStateProperty.all(vinho),
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
      ),
      onGenerateRoute: (settings) {
        Widget child = Container();
        switch (settings.name) {
          case '/':
            child = const HomeScreen();
            break;
          case 'new-game':
            child = const DashboardScreen();
            break;
        }
        return MaterialPageRoute<Widget>(builder: (_) => child);
      },
    );
  }
}
