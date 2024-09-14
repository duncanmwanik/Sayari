import 'dart:async';

import '../../../_helpers/_common/global.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/colors.dart';
import '../../../_variables/constants.dart';
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

void startTimer(String type, {int? remainingTime}) {
  Duration timer = Duration(minutes: int.parse(state.pomodoro.data['${type}t'] ?? '1'));

  state.pomodoro.reset();
  state.pomodoro.updateCurrentTimer(type);
  state.pomodoro.updateStartStop(remainingTime != null ? Duration(seconds: remainingTime) : timer);

  state.pomodoro.updateCounter(Timer.periodic(Duration(seconds: 1), (counter_) {
    // if timer is done
    if (getRemainingTime() == 0) {
      printThis('done timing');
      counter_.cancel();
      state.pomodoro.reset();
      autoPlayTimers(type);
    }
    // show reminder if 5 minutes is left to stop timer
    if ((getRemainingTime() / 60) == 5) {
      showToast(2, '5 minutes left!');
    }
    if (getRemainingTime() == 5) {
      showToast(2, '5 seconds left!');
    }

    state.pomodoro.updateRemainingTime(getRemainingTime());
  }));

  if (type == 'f' || type == 'l') {
    state.pomodoro.updateTimerLoops();
  }

  printThis('${remainingTime != null ? 'resuming' : 'started'} timing: ${pomodoroTitles[type]}');
}

void playPauseTimer(String type) {
  // if it's not counting yet
  if (!state.pomodoro.isTiming) {
    startTimer(type);
    return;
  }

  if (state.pomodoro.isPaused) {
    // resume timimg
    state.pomodoro.updateIsPaused(false);
    startTimer(type, remainingTime: state.pomodoro.remainingTime);
  } else {
    // pause timimg
    state.pomodoro.updateIsPaused(true);
    state.pomodoro.cancelCounter();
  }
}

void autoPlayTimers(String previousType) {
  if (state.pomodoro.data['ap'] == '1') {
    String type = state.pomodoro.timerLoops == int.parse(state.pomodoro.data['longBreakInterval'] ?? '4')
        ? 'l'
        : previousType == 'f'
            ? 's'
            : 'f';

    showToast(
      2,
      'Time ${type == 'f' ? 'to' : 'for a'} <b>${pomodoroTitles[type]?.toLowerCase()}!</b>',
      color: backgroundColors[state.pomodoro.data['${type}c']]!.color,
    );
    startTimer(type);
  } else {
    String type = state.pomodoro.currentTimer;
    showToast(
      1,
      '<b>${type == 'f' ? 'Focus time' : type == 's' ? 'Short break' : 'Long break'}<b> is over!',
      color: backgroundColors[state.pomodoro.data['${type}c']]!.color,
    );
  }
}
