import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_providers/providers.dart';
import '../../../../../_widgets/others/others/divider.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../files/user_dp.dart';
import '../../../_w/quill_configs/editor.dart';

class BookingIntro extends StatelessWidget {
  const BookingIntro({super.key, required this.userId, required this.userName, required this.quills});

  final String userId;
  final String userName;
  final String quills;

  @override
  Widget build(BuildContext context) {
    state.quill.setQuillController(quills: quills);

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Container(
        padding: itemPaddingLarge(),
        decoration: BoxDecoration(
          color: styler.appColor(styler.isDark ? 0.5 : 0.7),
          borderRadius: BorderRadius.circular(borderRadiusMedium),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            UserDp(userId: userId, viewOnly: true),
            //
            mph(),
            //
            AppText(text: userName, size: onBoarding, fontWeight: FontWeight.w900),
            //
            AppDivider(height: mediumHeight()),
            //
            QuillEditor.basic(
              configurations: QuillEditorConfigurations(
                controller: state.quill.quillcontroller,
                scrollable: false,
                // readOnly: true,
                showCursor: false,
                customStyles: getQuillEditorStyle(),
              ),
            ),
            //
            mph(),
            //
          ],
        ),
      ),
    );
  }
}
