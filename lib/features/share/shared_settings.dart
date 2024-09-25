import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/helpers.dart';
import '../../_providers/input.dart';
import '../../_variables/features.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/dialogs/confirmation_dialog.dart';
import '../../_widgets/menu/menu_item.dart';
import '../../_widgets/others/checkbox.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/others/divider.dart';
import '../../_widgets/others/text.dart';
import '../_notes/bookings/_w/copy_link.dart';
import '_helpers/share.dart';

class Share extends StatelessWidget {
  const Share({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      Map data = input.data;
      bool isPublished = data['sp'] == '1';
      bool isExpanded = data['ep'] == '1';

      return Visibility(
          visible: data[feature.share] != null && input.isNote() && !isShare(),
          child: Padding(
            padding: paddingC('t8,b4'),
            child: AppButton(
              noStyling: true,
              showBorder: true,
              smallRightPadding: true,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  AppButton(
                    onPressed: () => input.update('ep', isExpanded ? '0' : '1'),
                    padding: EdgeInsets.zero,
                    noStyling: true,
                    hoverColor: transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppIcon(Icons.share_rounded, size: medium, faded: true),
                            spw(),
                            AppText(text: 'Share settings'),
                          ],
                        ),
                        //
                        Spacer(),
                        //
                        AppButton(
                          onPressed: () => input.update('ep', isExpanded ? '0' : '1'),
                          noStyling: true,
                          isSquare: true,
                          hoverColor: transparent,
                          child: AppIcon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 18, faded: true),
                        ),
                        spw(),
                        AppButton(
                          menuItems: [
                            MenuItem(
                              label: 'Unshare Note',
                              leading: Icons.delete_rounded,
                              onTap: () => showConfirmationDialog(
                                title: 'Unshare note <b>${input.data['t'] ?? ''}</b>?',
                                content: 'The note will also be unpublished, if published.',
                                yeslabel: 'Unshare',
                                onAccept: () {
                                  input.remove(feature.share);
                                  input.remove('sp');
                                  shareItem(delete: true, itemId: input.itemId);
                                },
                              ),
                            ),
                          ],
                          noStyling: true,
                          isSquare: true,
                          child: AppIcon(moreIcon, size: 18, faded: true),
                        ),
                        //
                      ],
                    ),
                  ),
                  //
                  if (isExpanded) sph(),
                  if (isExpanded) CopyLink(path: input.item.sharedLink()),
                  if (isExpanded) AppDivider(height: mediumHeight()),
                  //
                  if (isExpanded)
                    Padding(
                      padding: paddingM('l'),
                      child: AppText(
                        text: 'A published note will appear in the Sayari Blog.',
                        faded: true,
                        weight: isDark() ? FontWeight.w400 : null,
                      ),
                    ),
                  if (isExpanded) sph(),
                  //
                  if (isExpanded)
                    Wrap(
                      spacing: smallWidth(),
                      runSpacing: smallWidth(),
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        AppButton(
                          onPressed: () {
                            input.update('sp', isPublished ? '0' : '1');
                            shareItem(
                              update: true,
                              itemId: input.itemId,
                              updateData: {'sp': isPublished ? '0' : '1'},
                            );
                          },
                          smallRightPadding: true,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText(text: 'Publish'),
                              spw(),
                              AppCheckBox(isChecked: isPublished, smallPadding: true),
                            ],
                          ),
                        ),
                        AppText(text: ' • ', faded: true),
                        CopyLink(label: 'Copy blog link', path: input.item.sharedLink()),
                      ],
                    ),
                  //
                ],
              ),
            ),
          ));
    });
  }
}
