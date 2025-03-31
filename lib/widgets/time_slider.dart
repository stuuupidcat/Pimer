import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_state.dart';

enum MinTimeUnit {
  second,
  minute,
  hour,
}

int getMilliseconds(MinTimeUnit minTimeUnit) {
  switch (minTimeUnit) {
    case MinTimeUnit.second:
      return 1000;
    case MinTimeUnit.minute:
      return 60 * 1000;
    case MinTimeUnit.hour:
      return 3600 * 1000;
  }
}

String getLabel(MinTimeUnit minTimeUnit) {
  switch (minTimeUnit) {
    case MinTimeUnit.second:
      return 'Seconds';
    case MinTimeUnit.minute:
      return 'Minutes';
    case MinTimeUnit.hour:
      return 'Hours';
  }
}

class TimeSlider extends StatelessWidget {
  final MinTimeUnit minTimeUnit;
  const TimeSlider({super.key, required this.minTimeUnit});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<PimerAppState>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor:
              appState.isRunning ? Colors.grey : const Color(0xFF4A6E5C),
          inactiveTrackColor: appState.isRunning
              ? Colors.grey.withOpacity(0.3)
              : const Color(0xFFA7D2A3).withOpacity(0.3),
          thumbColor:
              appState.isRunning ? Colors.grey : const Color(0xFF4A6E5C),
          overlayColor: const Color(0xFFA7D2A3).withOpacity(0.1),
          trackHeight: 4,
          thumbShape: const RoundSliderThumbShape(
            enabledThumbRadius: 6,
            elevation: 2,
          ),
          overlayShape: const RoundSliderOverlayShape(
            overlayRadius: 12,
          ),
        ),
        child: Slider(
          value: appState.targetMilliseconds / getMilliseconds(minTimeUnit),
          min: 1,
          max: 360,
          divisions: 359,
          onChanged: appState.isRunning
              ? null
              : (value) {
                  appState.setTargetTime(minTimeUnit, value.round());
                },
        ),
      ),
    );
  }
}
