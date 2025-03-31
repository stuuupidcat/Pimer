import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_state.dart';
import '../widgets/timer_display.dart';
import '../widgets/time_slider.dart';
import '../widgets/timer_complete_dialog.dart';
import '../widgets/pimer_title.dart';
import '../widgets/timer_controls.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String formatTime(int milliseconds) {
    int hours = milliseconds ~/ 3600000;
    int minutes = (milliseconds % 3600000) ~/ 60000;
    int seconds = (milliseconds % 60000) ~/ 1000;
    int remainingMilliseconds = (milliseconds % 1000) ~/ 10;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${remainingMilliseconds.toString().padLeft(2, '0')}';
  }

  String getCountdownTime(int elapsedMilliseconds, int targetMilliseconds) {
    int remainingMilliseconds = targetMilliseconds - elapsedMilliseconds;
    if (remainingMilliseconds < 0) remainingMilliseconds = 0;
    return formatTime(remainingMilliseconds);
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<PimerAppState>();
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalSpacing = screenHeight * 0.02; // 2% of screen height

    // Set up the timer completion callback
    appState.setOnTimerComplete(() {
      TimerCompleteDialog.show(
        context,
        () => appState.resetTimer(appState.minTimeUnit),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PimerTitle(color: Color(0xFF35524A)),
            SizedBox(height: verticalSpacing * 0.5),
            TimerDisplay(
              time: formatTime(appState.totalTime),
              color: const Color(0xFF35524A),
              description: 'today',
            ),
            SizedBox(height: verticalSpacing),
            TimerDisplay(
              time: formatTime(appState.targetMilliseconds),
              color: const Color(0xFF4A6E5C),
              description: 'goal',
            ),
            SizedBox(height: verticalSpacing),
            TimerDisplay(
              time: getCountdownTime(
                  appState.milliseconds, appState.targetMilliseconds),
              color: const Color(0xFF5F896D),
              description: 'remain',
            ),
            SizedBox(height: verticalSpacing),
            TimerDisplay(
              time: formatTime(appState.milliseconds),
              color: const Color(0xFF74A57F),
              description: 'current',
            ),
            SizedBox(height: verticalSpacing),
            TimeSlider(minTimeUnit: appState.minTimeUnit),
            SizedBox(height: verticalSpacing),
            TimerControls(appState: appState),
          ],
        ),
      ),
    );
  }
}
