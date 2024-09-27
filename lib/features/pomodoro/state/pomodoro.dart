import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../_services/hive/local_storage_service.dart';
import '../var/variables.dart';

class PomodoroProvider with ChangeNotifier {
  //
  Map data = jsonDecode(settingBox.get('pm', defaultValue: defaultPomodoroData));
  // Map data = jsonDecode(defaultPomodoroData);

  void updatedata(String key, String value) {
    data[key] = value;
    notifyListeners();
  }

  void setdata(map) {
    data = map;
    notifyListeners();
  }

  // Actual timer, counts every second
  Timer? counter;

  void updateCounter(Timer timer) {
    isTiming = true;
    counter = timer;
    notifyListeners();
  }

  void cancelCounter() {
    if (counter != null && counter!.isActive) {
      counter!.cancel();
    }
    notifyListeners();
  }

  //
  String currentTimer = 'f';
  bool isTiming = false;
  bool isPaused = false;

  void updateCurrentTimer(String type) {
    currentTimer = type;
    notifyListeners();
  }

  void updateIsPaused(bool value) {
    isPaused = value;
    notifyListeners();
  }

  void reset() {
    cancelCounter();
    isTiming = false;
    isPaused = false;
    remainingTime = 0;
    notifyListeners();
  }

  // the remaining time in seconds for each timer
  int remainingTime = 0;

  void updateRemainingTime(int seconds) {
    remainingTime = seconds;
    notifyListeners();
  }

  // the time the current timer has started counting
  DateTime start = DateTime.now();
  // the time the current timer will stop counting
  DateTime end = DateTime.now();

  void updateStartStop(Duration timer) {
    start = DateTime.now();
    end = start.add(Duration(minutes: timer.inMinutes));
    notifyListeners();
  }

  //
  int timerLoops = 0;

  void updateTimerLoops() {
    timerLoops = timerLoops + 1;
    if (timerLoops == (int.parse(data['lbi'] ?? '4') + 1)) {
      timerLoops = 0;
    }
    notifyListeners();
  }

  //
}
