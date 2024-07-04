import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_providers/common/input.dart';
import '../../_variables/features.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/abcs/dialogs_sheets/confirmation_dialog.dart';
import '../../_widgets/abcs/menu/menu_item.dart';
import '../../_widgets/others/checkbox.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '../_notes/_helpers/share.dart';

class Share extends StatelessWidget {
  const Share({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      Map data = input.data;
      bool isPublished = data['sp'] == '1';
      bool isExpanded = data['sx'] == '1';

      return Visibility(
          visible: data[feature.share.lt] != null,
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
                      onPressed: () => input.update(action: 'add', key: 'sx', value: isExpanded ? '0' : '1'),
                      noStyling: true,
                      isSquare: true,
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
                      onPressed: () => input.update(action: 'add', key: 'sx', value: isExpanded ? '0' : '1'),
                      noStyling: true,
                      isSquare: true,
                      child: AppIcon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          size: 18, faded: true),
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
                              // input.removeAll(start: 's');
                              // shareItem(delete: true, itemId: input.itemId);
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
                //
                if (isExpanded) sph(),
                //
                if (isExpanded)

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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(text: 'Publish'),
                        Spacer(),
                        AppCheckBox(isChecked: isPublished, smallPadding: true)
                      ],
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
