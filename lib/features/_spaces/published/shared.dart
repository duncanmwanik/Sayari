import 'package:flutter/material.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/helpers.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/layout/note_list.dart';
import '../../../_widgets/others/others/divider.dart';
import '../../../_widgets/others/others/scroll.dart';
import '../../share/_w/header.dart';
import 'shared_intro.dart';

class PublishBookBody extends StatelessWidget {
  const PublishBookBody({super.key, required this.sharedData, required this.userName, required this.data});

  final Map sharedData;
  final String userName;
  final Map data;

  @override
  Widget build(BuildContext context) {
    return NoScrollBars(
      child: Column(
        children: [
          //
          SharedHeader(userId: sharedData['u'], data: data),
          //
          Expanded(
            child: isTabAndBelow()
                ? Padding(
                    padding: itemPadding(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        mph(),
                        PublishedBookIntro(sharedData: sharedData, data: data, userName: userName),
                        mph(),
                        AppDivider(height: 0),
                        mph(),
                        Flexible(child: ListOfItems(data: data)),
                      ],
                    ),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: itemPadding(top: true, left: true),
                        child: PublishedBookIntro(sharedData: sharedData, data: data, userName: userName),
                      ),
                      Expanded(
                          child: Container(
                        margin: itemPadding(left: true),
                        padding: itemPadding(left: true, right: true, top: true),
                        decoration: BoxDecoration(
                          border: Border(left: BorderSide(color: styler.borderColor(), width: isDark() ? 0.5 : 1)),
                        ),
                        child: ListOfItems(data: data),
                      )),
                    ],
                  ),
          ),
          //
        ],
      ),
    );
  }
}
