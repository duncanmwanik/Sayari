import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../_variables/features.dart';
import '../../../_variables/strings.dart';
import '../../_tables/_helpers/common.dart';

class PomodoroProvider with ChangeNotifier {
  //
  // user settings for pomodoro
  //
  Map pomodoroMap = Hive.box('${liveTable()}_${feature.pomodoro.t}').get('p', defaultValue: defaultPomodoroMap);

  void updatePomodoroMap(String key, String value) {
    pomodoroMap[key] = value;
    notifyListeners();
  }

  void setPomodoroMap(map) {
    pomodoroMap = map;
    notifyListeners();
  }

  //
  // Actual timer, counts every second
  //
  Timer? counter;

  void updateCounter(Timer timer) {
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
  //
  //
  String currentTimer = 'none';
  bool isTiming = false;
  bool isPaused = false;

  void updateCurrentTimer(String type) {
    currentTimer = type;
    isTiming = true;
    notifyListeners();
  }

  void updateIsPaused(bool value) {
    isPaused = value;
    notifyListeners();
  }

  void resetAllTimers() {
    currentTimer = 'none';
    isTiming = false;
    isPaused = false;
    remainingTimeBreak = 0;
    remainingTimeFocus = 0;
    remainingTimeLongBreak = 0;
    cancelCounter();
    notifyListeners();
  }

  //
  //
  //
  // the remaining time in seconds for each timer
  int remainingTimeFocus = 0;
  int remainingTimeBreak = 0;
  int remainingTimeLongBreak = 0;

  void updateRemainingTime(String type, int seconds) {
    if (type == 'focus') {
      remainingTimeFocus = seconds;
    }
    if (type == 'shortBreak') {
      remainingTimeBreak = seconds;
    }
    if (type == 'longBreak') {
      remainingTimeLongBreak = seconds;
    }
    notifyListeners();
  }

  //
  //
  //
  // the time the current timer has started counting
  DateTime start = DateTime.now();
  // the time the current timer will stop counting
  DateTime end = DateTime.now();

  void updateStartStop(Duration timer) {
    start = DateTime.now();
    end = start.add(Duration(seconds: timer.inSeconds));
    notifyListeners();
  }
  //
  //
  //

  int timerLoops = 0;

  void updateTimerLoops() {
    timerLoops = timerLoops + 1;
    if (timerLoops == (int.parse(pomodoroMap['longBreakInterval'] ?? '4') + 1)) {
      timerLoops = 0;
    }
    notifyListeners();
  }

  //
  //
  //
}
