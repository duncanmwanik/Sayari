import 'package:responsive_sizer/responsive_sizer.dart';

import 'variables.dart';

// ---------- ---------- ----------

bool isPhone() {
  return 100.w <= 500;
}

bool isNotPhone() {
  return 100.w > 500;
}

// ---------- ---------- ----------

bool isTabAndBelow() {
  return 100.w <= 768;
}

// ---------- ---------- ----------

bool isSmallPC() {
  return 100.w > 768;
}

// ---------- ---------- ----------

bool isLargePC() {
  return 100.w > 1200;
}

// ---------- ---------- ----------

bool showVertNav() {
  return 100.w >= 768;
}

bool showWebBoxOptions() {
  return 100.w >= 840;
}

// ---------- ---------- ----------
bool showSheetAsDialog() {
  return 100.w > webMaxWidth;
}
