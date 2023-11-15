import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tranqueiros/core/core.dart';

/// Input texts for the scores.
class EnterScoreWidget extends StatelessWidget {
  /// Input texts for the scores constructor.
  const EnterScoreWidget({
    required this.firstTeamController,
    required this.secondTeamController,
    super.key,
  });

  /// The first team text editing controller.
  final TextEditingController firstTeamController;

  /// The second team text editing controller.
  final TextEditingController secondTeamController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: TranqueirosAppTheme.colors.secondary,
                borderRadius: BorderRadius.circular(32),
              ),
              child: TextFormField(
                controller: firstTeamController,
                textAlign: TextAlign.center,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[-+]?\d*$')),
                ],
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 16),
                  hintText: '',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: TranqueirosAppTheme.colors.secondary,
                borderRadius: BorderRadius.circular(32),
              ),
              child: TextFormField(
                controller: secondTeamController,
                textAlign: TextAlign.center,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 16),
                  hintText: '',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
