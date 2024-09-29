import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../__styling/breakpoints.dart';
import '../__styling/variables.dart';
import '../_providers/_providers.dart';
import 'helpers.dart';

ScrollPhysics? shareScrollPhysics() => isShare() && isTabAndBelow() ? const NeverScrollableScrollPhysics() : null;

void setWebTitle(String title) {
  SystemChrome.setApplicationSwitcherDescription(
    ApplicationSwitcherDescription(label: title, primaryColor: styler.accentColor().value),
  );
}

void resetWebTitle() => setWebTitle('Sayari • ${capitalFirst(state.views.view)}');
