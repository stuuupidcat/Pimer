import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/timer_state.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const Pimer());
}

class Pimer extends StatelessWidget {
  const Pimer({super.key});

  static const title = 'Pimer App';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PimerAppState(),
      child: MaterialApp(
        title: title,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 56, 184, 28)),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
