import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  final String time;
  const TimerDisplay({
    super.key,
    required this.time,
  });

  TextStyle _getTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    return theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
      fontSize: 48,
      fontFamily: 'monospace',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 120,
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        child: Center(
          child: Text(
            time,
            style: _getTextStyle(context),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
