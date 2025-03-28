import 'package:flutter/material.dart';
import 'dart:async';

class PimerAppState extends ChangeNotifier {
  int _milliseconds = 0;
  bool _isRunning = false;
  Timer? _timer;

  int get milliseconds => _milliseconds;
  bool get isRunning => _isRunning;

  void startTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        _milliseconds += 10;
        notifyListeners();
      });
      notifyListeners();
    }
  }

  void pauseTimer() {
    if (_isRunning) {
      _isRunning = false;
      _timer?.cancel();
      notifyListeners();
    }
  }

  void resetTimer() {
    _isRunning = false;
    _timer?.cancel();
    _milliseconds = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
