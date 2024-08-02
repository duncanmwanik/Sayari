import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/text.dart';
import '../../_notes/_w/quill_configs/editor.dart';
import 'blog_info.dart';
import 'header.dart';

class BlogBody extends StatelessWidget {
  const BlogBody({super.key, required this.userId, required this.userName, required this.data});

  final String userId;
  final String userName;
  final Map data;

  @override
  Widget build(BuildContext context) {
    state.quill.setQuillController(quills: data['n']);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        SharedHeader(userId: userId, data: data),
        //
        Expanded(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: webMaxWidth),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  Padding(
                    padding: itemPadding(left: true, right: true),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        sph(),
                        //
                        AppText(text: data['t'], size: blogTitle, fontWeight: FontWeight.w800),
                        //
                        msph(),
                        //
                        BlogInfo(userId: userId, userName: userName, data: data),
                        //
                        AppDivider(height: mediumHeight()),
                        sph(),
                        //
                        QuillEditor.basic(
                          configurations: QuillEditorConfigurations(
                            controller: state.quill.quillcontroller,
                            scrollable: false,
                            showCursor: false,
                            customStyles: getQuillEditorStyle(),
                          ),
                        ),
                        //
                      ],
                    ),
                  ),
                  //
                  lpph(),
                  //
                ],
              ),
            ),
          ),
        )
        //
      ],
    );
  }
}
