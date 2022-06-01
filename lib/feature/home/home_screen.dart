import 'package:flutter/material.dart';
import 'package:tranqueiros/core/core.dart';

/// The home screen.
class HomeScreen extends StatelessWidget {
  /// The home screen constructor.
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const _HomeHeaderWidget(),
          const Expanded(child: Offstage()),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('new-game'),
                    child: const Text('NOVA PARTIDA'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeHeaderWidget extends StatelessWidget {
  const _HomeHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          ClipPath(
            clipper: _BackgroundWaveClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 280,
              decoration: BoxDecoration(
                color: TranqueirosAppTheme.colors.secondary,
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Hero(
              tag: 'logo-key',
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Image.asset('assets/icon.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    final curveHeight = size.height * 0.75;
    path.lineTo(0, curveHeight);

    final controlPoint = Offset(size.width * 0.5, size.height);
    final endPoint = Offset(size.width, curveHeight);
    path
      ..quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        endPoint.dx,
        endPoint.dy,
      )
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(_BackgroundWaveClipper oldClipper) => oldClipper != this;
}
