import 'package:flutter/material.dart';
import 'package:tranqueiros/core/core.dart';
import 'package:tranqueiros/feature/dashboard/domain/domain.dart';

/// List with every round.
class RoundScoreListWidget extends StatelessWidget {
  /// List with every round constructor.
  const RoundScoreListWidget({
    required this.scores,
    super.key,
  });

  /// The rounds list.
  final List<ScoreModel> scores;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, position) {
        return Container(
          height: 0.5,
          width: double.infinity,
          color: TranqueirosAppTheme.colors.secondary,
        );
      },
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: scores.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                scores[index].firstTeamScore.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Text(
                scores[index].secondTeamScore.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
