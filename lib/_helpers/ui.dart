import 'package:flutter/material.dart';

import '../__styling/breakpoints.dart';
import 'helpers.dart';

ScrollPhysics? shareScrollPhysics() => isShare() && isTabAndBelow() ? const NeverScrollableScrollPhysics() : null;
