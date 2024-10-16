// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../_services/hive/local_storage_service.dart';
import '../var/variables.dart';

class PomodoroProvider with ChangeNotifier {
  late Timer counter; // Actual timer, counts every second
  int remainingTime = 0; // the remaining time in seconds for each timer
  String currentTimer = 'f';
  bool isCounting = false;
  bool isPaused = false;
  int timerLoops = 0;

  void updateCounter(Timer timer) {
    isCounting = true;
    counter = timer;
    notifyListeners();
  }

  void cancelCounter() {
    if (counter != null && counter.isActive) {
      counter.cancel();
    }
  }

  void updateIsPaused(bool value) {
    isPaused = value;
    notifyListeners();
  }

  void reset([String? type]) {
    cancelCounter();
    if (type != null) currentTimer = type;
    isCounting = false;
    isPaused = false;
    remainingTime = 0;
    notifyListeners();
  }

  void updateRemainingTime(int seconds) {
    remainingTime = seconds;
    notifyListeners();
  }

  void updateTimerLoops() {
    timerLoops = timerLoops + 1;
    if (timerLoops == (int.parse(data['lbi'] ?? '4') + 1)) {
      timerLoops = 0;
    }
    notifyListeners();
  }

  // pomodoro data
  Map data = jsonDecode(settingBox.get('pm', defaultValue: defaultPomodoroData));

  void updatedata(String key, String value) {
    data[key] = value;
    notifyListeners();
  }

  void setdata(map) {
    data = map;
    notifyListeners();
  }
}
