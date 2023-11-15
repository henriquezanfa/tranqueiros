import 'package:flutter/material.dart';

/// The add score button.
class AddScoreButtonWidget extends StatelessWidget {
  /// The add score button constructor.
  const AddScoreButtonWidget({
    super.key,
    this.onPressed,
  });

  /// The onPressed callback.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            label: const Text(
              'Adicionar',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
