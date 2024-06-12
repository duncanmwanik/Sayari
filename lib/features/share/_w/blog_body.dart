import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/scroll.dart';
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

    return ScrollConfiguration(
      behavior: AppScrollBehavior().copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            tph(),
            SharedHeader(userId: userId, data: data),
            tph(),
            AppDivider(height: smallWidth()),
            sph(),
            //
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: webMaxWidth),
              child: Padding(
                padding: itemPadding(left: true, right: true),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //
                    AppText(text: data['t'], size: blogTitle, fontWeight: FontWeight.bold),
                    //
                    mph(),
                    //
                    BlogInfo(userId: userId, userName: userName, data: data),
                    //
                    mph(),
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
            ),
            //
            lpph(),
            lpph(),
            //
          ],
        ),
      ),
    );
  }
}
