import 'package:flutter/material.dart';
import 'package:tranqueiros/core/core.dart';

/// The splash screen
class SplashScreen extends StatefulWidget {
  /// The splash screen constructor
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0;
  @override
  void initState() {
    super.initState();
    _navigateToHome();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        opacity = 1;
      });
    });
  }

  void _navigateToHome() {
    Future<void>.delayed(const Duration(seconds: 2)).then((Object? _) {
      Navigator.of(context).pushReplacementNamed('home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 500),
      child: Scaffold(
        backgroundColor: TranqueirosAppTheme.colors.accent,
        body: Center(
          child: Hero(
            tag: 'logo-key',
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Image.asset('assets/icon.png'),
            ),
          ),
        ),
      ),
    );
  }
}
