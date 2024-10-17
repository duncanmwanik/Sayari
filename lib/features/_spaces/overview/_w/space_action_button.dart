import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/others/icons.dart';
import '../../_helpers/common.dart';

Widget spaceActionButton({required String label, required IconData iconData, Function()? onPressed}) {
  return Visibility(
    visible: isAdmin(),
    child: Padding(
      padding: padM('lr'),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: pad(),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcon(iconData),
              spw(),
              Text(
                label,
                style: GoogleFonts.inter(fontSize: medium),
              ),
            ],
          )),
    ),
  );
}
