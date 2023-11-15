import 'package:tranqueiros/feature/dashboard/domain/domain.dart';

/// The game model.
class GameModel {
  /// The game model constructor.
  GameModel({
    this.firstTeam,
    this.secondTeam,
  });

  /// The first team;
  TeamModel? firstTeam;

  /// The second team;
  TeamModel? secondTeam;

  /// The team scores.
  final List<ScoreModel> _scores = [];

  /// The getter to the scores.
  List<ScoreModel> get scores => _scores;

  /// Adds a new score to [_scores]
  void newScore(int firstTeamScore, int secondScoreTeam) {
    _scores.add(
      ScoreModel(
        firstTeamScore: firstTeamScore,
        secondTeamScore: secondScoreTeam,
      ),
    );
  }

  /// Deletes all data from [_scores]
  void clearScores() {
    _scores.clear();
  }

  /// Getter for the first team total score.
  int get firstTeamScore {
    if (_scores.isEmpty) return 0;
    return _scores.map((score) => score.firstTeamScore!).reduce(
          (a, b) => a + b,
        );
  }

  /// Getter for the second team total score.
  int get secondTeamScore {
    if (_scores.isEmpty) return 0;

    return _scores.map((item) => item.secondTeamScore!).reduce(
          (a, b) => a + b,
        );
  }
}
