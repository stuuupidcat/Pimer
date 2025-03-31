import 'package:flutter/material.dart';
import '../providers/timer_state.dart';

class TimerControls extends StatelessWidget {
  final PimerAppState appState;

  const TimerControls({
    super.key,
    required this.appState,
  });

  TextStyle _getTextStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize = (screenWidth * 0.06 + screenHeight * 0.03) /
        2; // Average of width and height based sizes
    return TextStyle(
      fontFamily: 'monospace',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: appState.isRunning
          ? const Color(0xFFFBAF00)
          : const Color(0xFF4A6E5C),
    );
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final buttonWidth = screenWidth * 0.35; // 35% of screen width
    final buttonHeight = screenHeight * 0.08; // 10% of screen height

    return ElevatedButton.styleFrom(
      fixedSize: Size(buttonWidth, buttonHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonSpacing = screenWidth * 0.08; // 8% of screen width

    var buttonLeft = ElevatedButton(
      onPressed: appState.isRunning ? appState.pauseTimer : appState.startTimer,
      style: _getButtonStyle(context),
      child: Text(
        appState.isRunning ? 'Pause' : 'Start',
        style: _getTextStyle(context),
      ),
    );

    var buttonRight = ElevatedButton(
      onPressed: () => appState.resetTimer(appState.minTimeUnit),
      style: _getButtonStyle(context),
      child: Text(
        'Reset',
        style: _getTextStyle(context).copyWith(
          color: const Color(0xFFD00000),
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buttonLeft,
        SizedBox(width: buttonSpacing),
        buttonRight,
      ],
    );
  }
}
