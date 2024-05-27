import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/misc.dart';
import '../../_helpers/items/share.dart';
import '../../_providers/common/input.dart';
import '../../_variables/strings.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/abcs/dialogs_sheets/confirmation_dialog.dart';
import '../../_widgets/abcs/menu/menu_item.dart';
import '../../_widgets/others/checkbox.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';

class Share extends StatelessWidget {
  const Share({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      Map data = input.data;
      bool isPublished = data['sp'] == '1';
      bool isExpanded = data['cx'] == '1';

      return Visibility(
          visible: data['sa'] != null,
          child: Container(
            margin: itemPadding(top: true, bottom: true),
            padding: itemPaddingMedium(),
            decoration: BoxDecoration(
              color: styler.appColor(1),
              borderRadius: BorderRadius.circular(borderRadiusSmall),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //
                    AppButton(
                      onPressed: () => input.update(action: 'add', key: 'cx', value: isExpanded ? '0' : '1'),
                      noStyling: true,
                      borderRadius: borderRadiusSmall,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppIcon(Icons.share_rounded, size: 16, faded: true),
                          spw(),
                          AppText(text: 'Shared'),
                        ],
                      ),
                    ),
                    //
                    Spacer(),
                    //
                    AppButton(
                      onPressed: () => input.update(action: 'add', key: 'cx', value: isExpanded ? '0' : '1'),
                      noStyling: true,
                      child: AppIcon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 18, faded: true),
                    ),
                    spw(),
                    AppButton(
                      menuItems: [
                        MenuItem(
                          label: 'Unshare Note',
                          iconData: Icons.delete_rounded,
                          onTap: () => showConfirmationDialog(
                            title: 'Unshare note <b>${input.data['t'] ?? ''}</b>?',
                            content: 'The note will also be unpublished, if published.',
                            yeslabel: 'Unshare',
                            onAccept: () {
                              input.removeAll(start: 's');
                              shareItem(delete: true, itemId: input.itemId);
                            },
                          ),
                        ),
                      ],
                      noStyling: true,
                      child: AppIcon(moreIcon, size: 18, faded: true),
                    ),
                    //
                  ],
                ),
                //
                if (isExpanded) sph(),
                //
                if (isExpanded)
                  AppButton(
                    onPressed: () async => await copyToClipboard('$sayariSharePath/${input.itemId}', desc: 'link'),
                    borderRadius: borderRadiusSmall,
                    smallRightPadding: true,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: AppText(text: '$sayariSharePath/${input.itemId}', faded: true)),
                        spw(),
                        Padding(padding: const EdgeInsets.only(top: 1), child: AppIcon(Icons.copy, size: 18, faded: true)),
                      ],
                    ),
                  ),
                //
                if (isExpanded) sph(),
                //
                if (isExpanded)
                  AppButton(
                    onPressed: () {
                      input.update(action: 'add', key: 'sp', value: isPublished ? '0' : '1');
                      shareItem(update: true, itemId: input.itemId, key: 'p', value: isPublished ? '0' : '1');
                    },
                    height: 35,
                    borderRadius: borderRadiusSmall,
                    smallRightPadding: true,
                    child: Row(
                      children: [AppText(text: 'Publish'), Spacer(), AppCheckBox(isChecked: isPublished, smallPadding: true)],
                    ),
                  ),
                //
                if (isExpanded) tph(),
                //
                if (isExpanded)
                  Padding(
                    padding: itemPaddingMedium(left: true),
                    child: AppText(text: 'A published note will appear in the Sayari Blog.', faded: true),
                  ),
                //
                if (isExpanded) tph(),
                //
              ],
            ),
          ));
    });
  }
}
