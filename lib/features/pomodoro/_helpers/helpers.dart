import 'dart:async';

import '../../../_helpers/_common/global.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/strings.dart';
import '../../../_widgets/others/toast.dart';

int getRemainingTime() => state.pomodoro.end.difference(DateTime.now()).inSeconds;

String getRemainingTimeString() {
  int remainingTime = state.pomodoro.end.difference(DateTime.now()).inSeconds;

  String seconds = (remainingTime % 60).toString();
  String minutes = (remainingTime / 60).truncate().toString();

  return '${minutes.length < 2 ? '0$minutes' : minutes}:${seconds.length < 2 ? '0$seconds' : seconds}';
}

String getTimerString(Duration timer) {
  int time = timer.inSeconds;

  String seconds = (time % 60).toString();
  String minutes = (time / 60).truncate().toString();

  return '${minutes.length < 2 ? '0$minutes' : minutes}:${seconds.length < 2 ? '0$seconds' : seconds}';
}

void startTimer(String type, Duration timer, {int? remainingTime}) {
  state.pomodoro.updateStartStop(remainingTime != null ? Duration(seconds: remainingTime) : timer);

  state.pomodoro.updateCounter(Timer.periodic(const Duration(seconds: 1), (counter_) {
    // if timer is done
    if (getRemainingTime() == 0) {
      printThis('done timing');
      counter_.cancel();
      state.pomodoro.resetAllTimers();
      autoPlayTimers(type);
    }
    // show reminder if 5 minutes is left to stop timer
    // if ((getRemainingTime() / 60) == 5) {
    if (getRemainingTime() == 5) {
      showToast(2, '5 Minutes left!');
    }
    state.pomodoro.updateRemainingTime(type, getRemainingTime());
  }));

  if (type == 'focus' || type == 'longBreak') {
    state.pomodoro.updateTimerLoops();
  }

  printThis('${remainingTime != null ? 'resuming' : 'started'} timing: $type');
}

void manageTimer(String type, Duration timer, int remainingTime) {
  if (state.pomodoro.currentTimer != type) {
    state.pomodoro.resetAllTimers();
  }

  // Pausing / Resuming
  if (state.pomodoro.currentTimer != 'none') {
    if (state.pomodoro.isPaused) {
      // resume timimg
      state.pomodoro.updateIsPaused(false);
      startTimer(type, timer, remainingTime: remainingTime);
    } else {
      // pause timimg
      state.pomodoro.updateIsPaused(true);
      state.pomodoro.cancelCounter();
      printThis('pausing timing');
    }
  }

  // Start / Stop Timer
  else {
    state.pomodoro.resetAllTimers();
    state.pomodoro.updateCurrentTimer(type);
    startTimer(type, timer);
  }
  //
}

void autoPlayTimers(String previousType) {
  String type = state.pomodoro.timerLoops == int.parse(state.pomodoro.pomodoroMap['longBreakInterval'] ?? '4')
      ? 'longBreak'
      : previousType == 'focus'
          ? 'shortBreak'
          : 'focus';

  if (state.pomodoro.pomodoroMap['autoPlay'] == '1') {
    printThis('autoplaying');

    showToast(1, 'Time ${type == 'focus' ? 'to' : 'for'} ${pomodoroTitles[type]?.toLowerCase()}!');

    Duration timer = Duration(seconds: int.parse(state.pomodoro.pomodoroMap['${type}Time'] ?? '0'));

    state.pomodoro.updateCurrentTimer(type);
    startTimer(type, timer);
  } else {
    showToast(1, '${pomodoroTitles[previousType]} is done!');
  }
}
