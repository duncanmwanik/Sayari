import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/_common/global.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../../_widgets/others/toast.dart';
import '../../../../files/image.dart';
import '../../../../share/_w/footer.dart';
import '../../../../share/_w/shared_info.dart';
import 'intro.dart';

class LinksBody extends StatelessWidget {
  const LinksBody(
      {super.key,
      required this.tableId,
      required this.itemId,
      required this.userId,
      required this.userName,
      required this.data});

  final String tableId;
  final String itemId;
  final String userId;
  final String userName;
  final Map data;

  @override
  Widget build(BuildContext context) {
    bool isActive = data['wa'] == '1';
    List linkKeys = getSplitList(data['wo']);

    return isActive
        ? ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  lph(),
                  //
                  LinksIntro(userId: userId, userName: userName, data: data),
                  //
                  mph(),
                  //
                  Wrap(
                    runSpacing: smallHeight(),
                    children: List.generate(linkKeys.length, (index) {
                      Map linkData = jsonDecode(data[linkKeys[index]] ?? '{}');
                      String title = linkData['wt'] ?? '---';
                      String link = linkData['wl'] ?? '';
                      String linkImageId = linkData['wf'] ?? '';

                      return AppButton(
                        onPressed: () => showToast(3, link),
                        borderRadius: borderRadiusMediumSmall,
                        padding: itemPaddingMedium(),
                        child: Row(
                          children: [
                            //
                            AppButton(
                              padding: EdgeInsets.zero,
                              borderRadius: borderRadiusSmall,
                              child: linkImageId.isNotEmpty
                                  ? ImageFile(
                                      linkImageId,
                                      data[linkImageId] ?? '',
                                      {linkImageId: data[linkImageId] ?? ''},
                                      isLinks: true,
                                      size: 40,
                                    )
                                  : SizedBox(width: 40, height: 40, child: AppIcon(Icons.link)),
                            ),
                            //
                            mpw(),
                            //
                            Expanded(child: AppText(text: title, size: normal)),
                            //
                          ],
                        ),
                      );
                    }),
                  ),
                  //
                  spph(),
                  //
                  SharedFooter(),
                  //
                  lpph(),
                  //
                ],
              ),
            ),
          )
        : SharedItemInfo(label: 'Oh man! This is the missing link.');
  }
}
