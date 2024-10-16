import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/_providers.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/quill/editor.dart';
import '../../share/w/header.dart';
import 'blog_info.dart';

class BlogBody extends StatelessWidget {
  const BlogBody({super.key, required this.id, required this.userId, required this.userName, required this.data});

  final String id;
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
          child: NoScrollBars(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: webMaxWidth),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //
                    Padding(
                      padding: padding(s: 'lr'),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //
                          sph(),
                          AppText(text: data['t'], size: largeTitle, weight: FontWeight.bold),
                          msph(),
                          BlogInfo(id: id, userId: userId, userName: userName, data: data),
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
          ),
        )
        //
      ],
    );
  }
}
