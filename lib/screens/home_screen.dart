import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_state.dart';
import '../widgets/timer_display.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String formatTime(int milliseconds) {
    int hours = milliseconds ~/ 3600000;
    int minutes = (milliseconds % 3600000) ~/ 60000;
    int seconds = (milliseconds % 60000) ~/ 1000;
    int remainingMilliseconds = (milliseconds % 1000) ~/ 10;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${remainingMilliseconds.toString().padLeft(2, '0')}';
  }

  String getCountdownTime(int elapsedMilliseconds) {
    const targetMilliseconds = 5 * 60 * 60 * 1000; // 5 hours in milliseconds
    int remainingMilliseconds = targetMilliseconds - elapsedMilliseconds;
    if (remainingMilliseconds < 0) remainingMilliseconds = 0;
    return formatTime(remainingMilliseconds);
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<PimerAppState>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TimerDisplay(time: '05:00:00.00'),
            const SizedBox(height: 10),
            TimerDisplay(time: getCountdownTime(appState.milliseconds)),
            const SizedBox(height: 10),
            TimerDisplay(time: formatTime(appState.milliseconds)),
            const SizedBox(height: 20),
            TimerControls(appState: appState),
          ],
        ),
      ),
    );
  }
}

class TimerControls extends StatelessWidget {
  final PimerAppState appState;

  const TimerControls({
    super.key,
    required this.appState,
  });

  TextStyle _getTextStyle() {
    return const TextStyle(
        fontFamily: 'monospace', fontSize: 30, fontWeight: FontWeight.bold);
  }

  ButtonStyle _getButtonStyle(BuildContext context, Color color) {
    return ElevatedButton.styleFrom(
      fixedSize: const Size(150, 100),
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var buttonLeft = ElevatedButton(
      onPressed: appState.isRunning ? appState.pauseTimer : appState.startTimer,
      style: _getButtonStyle(
        context,
        appState.isRunning ? Colors.orange : Colors.green,
      ),
      child: Text(
        appState.isRunning ? 'Pause' : 'Start',
        style: _getTextStyle(),
      ),
    );

    var buttonRight = ElevatedButton(
      onPressed: appState.resetTimer,
      style: _getButtonStyle(context, Colors.red),
      child: Text(
        'Reset',
        style: _getTextStyle(),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buttonLeft,
        const SizedBox(width: 30),
        buttonRight,
      ],
    );
  }
}
