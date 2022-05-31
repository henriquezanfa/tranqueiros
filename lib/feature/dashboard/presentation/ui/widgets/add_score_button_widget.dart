import 'package:flutter/material.dart';
import 'package:tranqueiros/core/consts.dart';

/// The add score button.
class AddScoreButtonWidget extends StatelessWidget {
  /// The add score button constructor.
  const AddScoreButtonWidget({
    Key? key,
    this.onPressed,
  }) : super(key: key);

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
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(vinho),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
            onPressed: onPressed,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(18),
            // ),
          ),
        ),
      ),
    );
  }
}
