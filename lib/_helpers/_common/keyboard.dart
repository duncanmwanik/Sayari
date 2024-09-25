import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../_providers/_providers.dart';
import '../../_variables/navigation.dart';

void listenToKeyboardChanges() {
  keyboardSubscription = KeyboardVisibilityController().onChange.listen((bool isKeyboardVisible) {
    state.global.updateIsKeyboardOpen(isKeyboardVisible);

    if (!isKeyboardVisible) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  });
}

void disposelListeningToKeyboardChanges() {
  keyboardSubscription.cancel();
}
