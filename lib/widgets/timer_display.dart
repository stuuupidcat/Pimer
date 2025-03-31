import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  final String time;
  final Color color;
  final String description;
  const TimerDisplay({
    super.key,
    required this.time,
    required this.color,
    required this.description,
  });

  TextStyle _getTextStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize = (screenWidth * 0.10 + screenHeight * 0.05) /
        2; // Average of width and height based sizes
    final theme = Theme.of(context);
    return theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
      fontFamily: 'monospace',
    );
  }

  TextStyle _getDescriptionStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize = (screenWidth * 0.04 + screenHeight * 0.02) /
        2; // Average of width and height based sizes
    final theme = Theme.of(context);
    return theme.textTheme.bodyLarge!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: fontSize,
      fontFamily: 'monospace',
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final width = screenWidth * 0.85; // 85% of screen width
    final height = screenHeight * 0.15; // 15% of screen height

    return SizedBox(
      width: width,
      height: height,
      child: Card(
        color: color,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: height * 0.1), // Add 10% padding at the top
              child: Center(
                child: Text(
                  time,
                  style: _getTextStyle(context),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              left: width * 0.02, // 5% of width
              top: height * 0.02, // 10% of height
              child: Text(
                description,
                style: _getDescriptionStyle(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
