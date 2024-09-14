import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/_common/global.dart';
import '../../../../../_widgets/buttons/buttons.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/others/scroll.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../../_widgets/others/theme.dart';
import '../../../../files/image.dart';
import '../../../../share/_w/shared_info.dart';
import '../_helpers/helpers.dart';
import 'intro.dart';
import 'share_menu.dart';

class LinksBody extends StatelessWidget {
  const LinksBody(
      {super.key, required this.spaceId, required this.itemId, required this.userId, required this.userName, required this.data});

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
        ? SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                //
                Expanded(
                  child: NoScrollBars(
                    child: SingleChildScrollView(
                      padding: padding(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 500),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //
                            spph(),
                            //
                            LinksIntro(userId: userId, userName: userName, data: data),
                            //
                            Wrap(
                              runSpacing: smallHeight(),
                              children: List.generate(linkKeys.length, (index) {
                                String linkId = linkKeys[index];
                                Map linkData = jsonDecode(data[linkId] ?? '{}');
                                String title = linkData['t'] ?? '---';
                                String link = linkData['l'] ?? '';
                                String linkImageId = linkData['f'] ?? '';
                                bool isTitle = linkId.startsWith('lkt');

                                return AppButton(
                                  onPressed: isTitle ? null : () => openLink(link),
                                  borderRadius: borderRadiusMediumSmall,
                                  padding: paddingC('l8,t8,r3,b8'),
                                  noStyling: isTitle,
                                  child: Row(
                                    children: [
                                      //
                                      if (!isTitle)
                                        AppButton(
                                          padding: EdgeInsets.zero,
                                          borderRadius: borderRadiusSmall,
                                          noStyling: linkImageId.isEmpty,
                                          child: linkImageId.isNotEmpty
                                              ? ImageFile(
                                                  linkImageId,
                                                  data[linkImageId] ?? '',
                                                  images: {linkImageId: data[linkImageId] ?? ''},
                                                  size: 30,
                                                  showOptions: false,
                                                  ignore: true,
                                                )
                                              : SizedBox(width: 30, height: 30, child: AppIcon(Icons.link)),
                                        ),
                                      if (!isTitle) mpw(),
                                      //
                                      Expanded(
                                          child: AppText(
                                        text: title,
                                        size: isTitle ? extra : normal,
                                        fontWeight: isTitle ? FontWeight.w800 : null,
                                        textAlign: isTitle ? TextAlign.center : null,
                                      )),
                                      //
                                      if (!isTitle) mpw(),
                                      if (!isTitle) ShareOptions(title: title, link: link),
                                      if (!isTitle) tpw(),
                                      //
                                    ],
                                  ),
                                );
                              }),
                            ),
                            //
                            lph(),
                            QuickThemeChanger(rightPadding: false),
                            sph(),
                            SharedAction(hasInfo: false),
                            //
                            lph(),
                            //
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : SharedAction(label: 'Oops! Missing link.');
  }
}
