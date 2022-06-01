import 'package:flutter/material.dart';
import 'package:tranqueiros/core/core.dart';

/// The score of each team.
class ScoreWidget extends StatelessWidget {
  /// The score of each team constructor
  const ScoreWidget({
    Key? key,
    required this.firstTeamScore,
    required this.secondTeamScore,
  }) : super(key: key);

  /// The first team score.
  final int firstTeamScore;

  /// The second team score
  final int secondTeamScore;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Card(
        color: TranqueirosAppTheme.colors.accent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '$firstTeamScore',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                '$secondTeamScore',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
