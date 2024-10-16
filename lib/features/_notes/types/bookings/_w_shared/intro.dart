import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../../../_providers/_providers.dart';
import '../../../../../_theme/spacing.dart';
import '../../../../../_theme/variables.dart';
import '../../../../../_widgets/others/others/divider.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../../_widgets/quill/editor_style.dart';
import '../../../../user/dp.dart';

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
        padding: padL(),
        decoration: BoxDecoration(
          color: styler.appColor(styler.isDark ? 0.5 : 0.7),
          borderRadius: BorderRadius.circular(borderRadiusMedium),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            UserDp(onPressed: () {}, userId: userId, size: 40),
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
