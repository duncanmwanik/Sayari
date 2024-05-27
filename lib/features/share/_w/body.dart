import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/others/text.dart';
import '../../files/user_dp.dart';
import '../../notes/quill_configs/editor.dart';
import 'actions.dart';

class SharedBody extends StatelessWidget {
  const SharedBody({super.key, required this.userId, required this.userName, required this.data});

  final String userId;
  final String userName;
  final Map data;

  @override
  Widget build(BuildContext context) {
    state.quill.setQuillController(quills: data['n']);
    String editTime = getEditDateTime(data['z'] ?? '${DateTime.now().millisecondsSinceEpoch}');

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: webMaxWidth),
      child: Padding(
        padding: itemPadding(left: true, right: true),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              mph(),
              //
              Row(
                children: [
                  UserDp(userId: userId, viewOnly: true, isTiny: true, size: 20),
                  spw(),
                  Flexible(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(text: userName, size: normal, faded: true, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                      AppText(text: editTime, faded: true, overflow: TextOverflow.ellipsis),
                    ],
                  )),
                ],
              ),
              //
              sph(),
              //
              Align(alignment: AlignmentDirectional.centerEnd, child: SharedActions(userId: userId, data: data)),
              //
              msph(),
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
      ),
    );
  }
}
