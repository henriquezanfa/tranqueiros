import 'package:flutter/material.dart';
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: TranqueirosAppTheme.colors.primary,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: UserPhotosWidget()),
            SliverAppBar(
              pinned: true,
              stretch: true,
              elevation: 0,
              expandedHeight: 100,
              automaticallyImplyLeading: false,
              backgroundColor: theme.primaryColor,
              toolbarHeight: 100,
              flexibleSpace: ScoreWidget(
                firstTeamScore: game.firstTeamScore,
                secondTeamScore: game.secondTeamScore,
              ),
            ),
            SliverToBoxAdapter(
              child: RoundScoreListWidget(scores: game.scores),
            ),
            SliverToBoxAdapter(
              child: EnterScoreWidget(
                firstTeamController: _firstTeamController,
                secondTeamController: _secondTeamController,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AddScoreButtonWidget(onPressed: _onTapAddButton),
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
