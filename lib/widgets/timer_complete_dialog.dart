import 'package:flutter/material.dart';
import 'package:flutter_fireworks/fireworks_controller.dart';
import 'package:flutter_fireworks/fireworks_display.dart';

class TimerCompleteDialog extends StatefulWidget {
  final VoidCallback onReset;
  const TimerCompleteDialog({
    super.key,
    required this.onReset,
  });

  static Future<void> show(BuildContext context, VoidCallback onReset) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return TimerCompleteDialog(onReset: onReset);
      },
    );
  }

  @override
  State<TimerCompleteDialog> createState() => _TimerCompleteDialogState();
}

class _TimerCompleteDialogState extends State<TimerCompleteDialog> {
  final FireworksController _fireworksController = FireworksController(
    minParticleCount: 50,
    maxParticleCount: 150,
    fadeOutDuration: 0.1,
  );

  @override
  void initState() {
    super.initState();
    // Fire multiple rockets when the dialog appears
    _fireworksController.fireMultipleRockets();
  }

  @override
  void dispose() {
    _fireworksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: const Text(
            'Good Job!',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 35,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(fontFamily: 'monospace'),
              ),
              onPressed: () {
                widget.onReset();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        FireworksDisplay(
          controller: _fireworksController,
        ),
      ],
    );
  }
}
