import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_providers/_providers.dart';
import '../../../../_widgets/others/others/divider.dart';
import '../../../../_widgets/others/text.dart';
import '../../../user/user_dp.dart';
import '../../_w/quill/editor_style.dart';

class BookingIntro extends StatelessWidget {
  const BookingIntro({
    super.key,
    required this.userId,
    required this.userName,
    required this.title,
    required this.quills,
  });

  final String userId;
  final String userName;
  final String title;
  final String quills;

  @override
  Widget build(BuildContext context) {
    state.quill.reset(quills: quills);

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Container(
        padding: paddingL(),
        decoration: BoxDecoration(
          color: styler.appColor(styler.isDark ? 0.5 : 0.7),
          borderRadius: BorderRadius.circular(borderRadiusMedium),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            UserDp(onPressed: () {}, userId: userId, noViewer: true, size: 40),
            sph(),
            AppText(text: userName, size: 22, weight: FontWeight.bold),
            mph(),
            AppText(text: title, weight: FontWeight.bold),
            //
            if (!state.quill.controller.document.isEmpty()) AppDivider(height: mediumHeight()),
            //
            QuillEditor.basic(
              configurations: QuillEditorConfigurations(
                controller: state.quill.controller,
                scrollable: false,
                showCursor: false,
                customStyles: getQuillEditorStyle(),
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
