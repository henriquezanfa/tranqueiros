import 'package:flutter/material.dart';
import 'package:tranqueiros/feature/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:tranqueiros/feature/home/home_screen.dart';
import 'package:tranqueiros/feature/splash/splash_screen.dart';

/// The routes for the app.
Route onGenerateRoute(RouteSettings settings) {
  Widget child = Container();
  switch (settings.name) {
    case '/':
      child = const SplashScreen();
      break;
    case 'home':
      child = const HomeScreen();
      break;
    case 'new-game':
      child = const DashboardScreen();
      break;
  }

  if (settings.name == 'home') {
    return PageRouteBuilder<Widget>(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        final tween = Tween(begin: begin, end: end);
        final opacityAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: opacityAnimation,
          child: child,
        );
      },
    );
  } else {
    return MaterialPageRoute<Widget>(builder: (_) => child);
  }
}
