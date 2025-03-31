import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pimer/widgets/time_slider.dart';

class PimerAppState extends ChangeNotifier {
  MinTimeUnit minTimeUnit;
  late int _targetMilliseconds;
  static const String _totalTimeKey = 'total_time';
  int _totalTime = 0;

  Timer? _timer;
  VoidCallback? _onTimerComplete;

  int _milliseconds = 0;
  bool _isRunning = false;

  int get milliseconds => _milliseconds;
  bool get isRunning => _isRunning;
  int get targetMilliseconds => _targetMilliseconds;
  int get totalTime => _totalTime;

  PimerAppState({required this.minTimeUnit}) {
    _targetMilliseconds = getMilliseconds(minTimeUnit);
    _loadTotalTime();
  }

  Future<void> _loadTotalTime() async {
    final prefs = await SharedPreferences.getInstance();
    _totalTime = prefs.getInt(_totalTimeKey) ?? 0;
    notifyListeners();
  }

  Future<void> _saveTotalTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_totalTimeKey, _totalTime);
  }

  void setOnTimerComplete(VoidCallback callback) {
    _onTimerComplete = callback;
  }

  void setTargetTime(MinTimeUnit minTimeUnit, int value) {
    _targetMilliseconds = getMilliseconds(minTimeUnit) * value;
    notifyListeners();
  }

  void startTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        _milliseconds += 10;
        if (_milliseconds >= _targetMilliseconds) {
          _onTimerComplete?.call();
          pauseTimer();
        }
        notifyListeners();
      });
      notifyListeners();
    }
  }

  void pauseTimer() {
    if (_isRunning) {
      _isRunning = false;
      _timer?.cancel();
      _totalTime += _milliseconds;
      _saveTotalTime();
      print('Total time today: ${_formatTime(_totalTime)}');
      notifyListeners();
    }
  }

  void resetTimer(MinTimeUnit minTimeUnit) {
    _isRunning = false;
    _timer?.cancel();
    _milliseconds = 0;
    _targetMilliseconds = getMilliseconds(minTimeUnit) * 1;
    notifyListeners();
  }

  String _formatTime(int milliseconds) {
    int hours = milliseconds ~/ 3600000;
    int minutes = (milliseconds % 3600000) ~/ 60000;
    int seconds = (milliseconds % 60000) ~/ 1000;
    int remaining = milliseconds % 1000;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${remaining.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
