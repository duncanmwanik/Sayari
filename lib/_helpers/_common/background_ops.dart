import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import '../../_providers/providers.dart';

void onResumedAppState(AppLifecycleState lifecycleState) {
  if (lifecycleState == AppLifecycleState.resumed) {
    if (!kIsWeb) {
      state.theme.enableThemeType();
    }
  }
}
