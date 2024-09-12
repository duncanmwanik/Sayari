import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/text.dart';
import '../../_notes/quill/editor.dart';
import 'blog_info.dart';
import 'header.dart';

class BlogBody extends StatelessWidget {
  const BlogBody({super.key, required this.itemId, required this.userId, required this.userName, required this.data});

  final String itemId;
  final String userId;
  final String userName;
  final Map data;

  @override
  Widget build(BuildContext context) {
    state.quill.reset(quills: data['n']);

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
                        //
                        sph(),
                        AppText(text: data['t'], size: blogTitle, fontWeight: FontWeight.w800),
                        msph(),
                        BlogInfo(itemId: itemId, userId: userId, userName: userName, data: data),
                        AppDivider(height: mediumHeight()),
                        sph(),
                        SuperEditor(),
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
