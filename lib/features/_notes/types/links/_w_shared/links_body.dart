import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/_common/global.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/others/scroll.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../files/image.dart';
import '../../../../share/_w/header.dart';
import '../../../../share/_w/shared_info.dart';
import '../_helpers/helpers.dart';
import 'intro.dart';

class LinksBody extends StatelessWidget {
  const LinksBody({super.key, required this.spaceId, required this.itemId, required this.userId, required this.userName, required this.data});

  final String spaceId;
  final String itemId;
  final String userId;
  final String userName;
  final Map data;

  @override
  Widget build(BuildContext context) {
    bool isActive = data['la'] == '1';
    List linkKeys = getSplitList(data['lo']);

    return isActive
        ? Column(
            children: [
              //
              SharedHeader(userId: userId, data: data),
              //
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 500),
                  child: NoScrollBars(
                    child: SingleChildScrollView(
                      padding: itemPadding(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //
                          LinksIntro(userId: userId, userName: userName, data: data),
                          //
                          Wrap(
                            runSpacing: smallHeight(),
                            children: List.generate(linkKeys.length, (index) {
                              Map linkData = jsonDecode(data[linkKeys[index]] ?? '{}');
                              String title = linkData['t'] ?? '---';
                              String link = linkData['l'] ?? '';
                              String linkImageId = linkData['f'] ?? '';

                              return AppButton(
                                onPressed: () => openLink(link),
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
                                              images: {linkImageId: data[linkImageId] ?? ''},
                                              size: 40,
                                              showOptions: false,
                                              ignore: true,
                                            )
                                          : SizedBox(width: 40, height: 40, child: AppIcon(Icons.link)),
                                    ),
                                    //
                                    mpw(),
                                    //
                                    Expanded(child: AppText(text: title, size: normal)),
                                    //
                                    // lpw(),
                                    // AppIcon(Icons.arrow_forward_rounded),
                                    tpw(),
                                    //
                                  ],
                                ),
                              );
                            }),
                          ),
                          //
                          lpph(),
                          //
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : SharedItemInfo(label: 'Oops! Missing link.');
  }
}
