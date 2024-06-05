import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_providers/providers.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../files/image.dart';
import '../../../../files/user_dp.dart';
import '../../../_w/quill_configs/editor.dart';

class FormsIntro extends StatelessWidget {
  const FormsIntro({super.key, required this.userId, required this.userName, required this.data});

  final String userId;
  final String userName;
  final Map data;

  @override
  Widget build(BuildContext context) {
    state.quill.setQuillController(quills: data['n']);
    String fileId = data['qf'] ?? '';
    String fileName = data[fileId] ?? '';
    bool hasImageDp = fileId.isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        hasImageDp
            ? AppButton(
                padding: EdgeInsets.zero,
                borderRadius: 500,
                child: ImageFile(
                  fileId,
                  fileName,
                  {fileId: fileName},
                  isLinks: true,
                  size: 120,
                  radius: 500,
                ),
              )
            : UserDp(userId: userId, viewOnly: true),
        //
        mph(),
        //
        AppText(text: userName, size: onBoarding, fontWeight: FontWeight.w900),
        //
        mph(),
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
    );
  }
}
