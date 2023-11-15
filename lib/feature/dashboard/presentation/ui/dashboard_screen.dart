import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tranqueiros/core/core.dart';
import 'package:tranqueiros/feature/dashboard/domain/domain.dart';
import 'package:tranqueiros/feature/dashboard/presentation/ui/widgets/widgets.dart';

/// Dashboard screen.
class DashboardScreen extends StatefulWidget {
  /// Dashboard screen constructor.
  const DashboardScreen({
    super.key,
    this.title = 'Tranqueiros',
  });

  /// The title of the page.
  final String title;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final game = GameModel(
    firstTeam: TeamModel(
      firstPlayerName: 'Marina',
      secondPlayerName: 'KIK',
    ),
    secondTeam: TeamModel(
      firstPlayerName: 'Bia',
      secondPlayerName: 'Miguel',
    ),
  );

  final TextEditingController _firstTeamController = TextEditingController();
  final TextEditingController _secondTeamController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TranqueirosAppTheme.colors.primary,
      appBar: AppBar(
        backgroundColor: TranqueirosAppTheme.colors.secondary,
        elevation: 4,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(widget.title, style: GoogleFonts.montserrat()),
        actions: [
          InkWell(
            onTap: () => setState(game.clearScores),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(
                Icons.delete_outline,
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          padding: const EdgeInsets.only(top: 16),
          child: Center(
            child: Column(
              children: <Widget>[
                const UserPhotosWidget(),
                ScoreWidget(
                  firstTeamScore: game.firstTeamScore,
                  secondTeamScore: game.secondTeamScore,
                ),
                Expanded(child: RoundScoreListWidget(scores: game.scores)),
                EnterScoreWidget(
                  firstTeamController: _firstTeamController,
                  secondTeamController: _secondTeamController,
                ),
                AddScoreButtonWidget(onPressed: _onTapAddButton),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAddButton() {
    final firstTeamScore = int.tryParse(_firstTeamController.text) ?? 0;
    final secondTeamScore = int.tryParse(_secondTeamController.text) ?? 0;

    setState(() {
      game.newScore(firstTeamScore, secondTeamScore);
      _firstTeamController.text = '';
      _secondTeamController.text = '';
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }
}
