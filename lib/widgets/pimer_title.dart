import 'package:flutter/material.dart';

class PimerTitle extends StatelessWidget {
  final Color? color;

  const PimerTitle({
    super.key,
    this.color,
  });

  TextStyle _getTextStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize = (screenWidth * 0.08 + screenHeight * 0.08) / 2;
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      fontFamily: 'monospace',
      color: color ?? Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildText(BuildContext context) {
    return Text(
      'Pimer',
      style: _getTextStyle(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'pimer_title',
      flightShuttleBuilder: (
        BuildContext flightContext,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,
      ) {
        return Material(
          color: Colors.transparent,
          child: _buildText(flightContext),
        );
      },
      child: Material(
        color: Colors.transparent,
        child: _buildText(context),
      ),
    );
  }
}
