import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_providers/providers.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../files/image.dart';
import '../../../../files/user_dp.dart';
import '../../../quill/editor_style.dart';

class LinksIntro extends StatelessWidget {
  const LinksIntro({super.key, required this.userId, required this.userName, required this.data});

  final String userId;
  final String userName;
  final Map data;

  @override
  Widget build(BuildContext context) {
    state.quill.reset(quills: data['n']);
    String fileId = data['cv'] ?? '';
    String fileName = data[fileId] ?? '';
    bool hasImageDp = fileId.isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        sph(),
        //
        hasImageDp
            ? AppButton(
                padding: EdgeInsets.zero,
                borderRadius: 500,
                child: ImageFile(
                  fileId,
                  fileName,
                  images: {fileId: fileName},
                  size: 120,
                  radius: 500,
                  showOptions: false,
                  ignore: true,
                  hoverColor: transparent,
                ),
              )
            : UserDp(userId: userId, noViewer: true),
        //
        mph(),
        //
        AppText(text: userName, size: title, fontWeight: FontWeight.w900),
        //
        mph(),
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
        if (!state.quill.isEmpty()) lph(),
        //
      ],
    );
  }
}
