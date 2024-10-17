import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../_providers/_providers.dart';

KeyboardListener keyboard = KeyboardListener();

class KeyboardListener {
  late StreamSubscription<bool> keyboardSubsdcription;

  void listen() {
    keyboardSubsdcription = KeyboardVisibilityController().onChange.listen((bool isKeyboardVisible) {
      state.global.updateIsKeyboardOpen(isKeyboardVisible);
      if (!isKeyboardVisible) FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  void cancel() => keyboardSubsdcription.cancel();
}
