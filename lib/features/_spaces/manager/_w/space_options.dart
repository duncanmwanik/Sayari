import 'package:flutter/material.dart';

import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/menu/menu_item.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/others/other.dart';
import '../../../user/_helpers/actions.dart';
import '../../_helpers/common.dart';
import '../../_helpers/delete.dart';

class SpaceOptions extends StatelessWidget {
  const SpaceOptions({super.key, required this.spaceId, required this.spaceName, required this.spaceGroupName});

  final String spaceId;
  final String spaceName;
  final String spaceGroupName;

  @override
  Widget build(BuildContext context) {
    bool isNotDefaultSpace = !isDefaultSpace(spaceId);

    return AppButton(
      tooltip: 'Options',
      isSquare: true,
      menuItems: [
        MenuItem(label: spaceName, faded: true, smallHeight: true, popTrailing: true),
        menuDivider(),
        //
        MenuItem(
          label: 'Add To Group',
          leading: Icons.drive_folder_upload_rounded,
          onTap: () => addSpaceToGroup(spaceId),
        ),
        //
        if (spaceGroupName.isNotEmpty)
          MenuItem(
            label: 'Remove From Group',
            leading: Icons.folder_off_rounded,
            onTap: () => removeSpaceFromGroup(spaceId, spaceGroupName),
          ),
        //
        if (isNotDefaultSpace)
          FutureBuilder(
              future: isOwner(spaceId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return NoWidget();
                  } else if (snapshot.hasData) {
                    final isOwner = snapshot.data as bool;

                    return isOwner
                        ? NoWidget()
                        : MenuItem(
                            label: 'Remove Space',
                            leading: Icons.remove_circle_outlined,
                            onTap: () => removeSpace(spaceId: spaceId, spaceName: spaceName),
                          );
                  }
                }
                return LinearProgressIndicator(color: styler.textColor(faded: true));
              }),
        //
        //
        if (isNotDefaultSpace)
          FutureBuilder(
              future: isOwner(spaceId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return NoWidget();
                  } else if (snapshot.hasData) {
                    final isOwner = snapshot.data as bool;

                    return isOwner
                        ? MenuItem(
                            label: 'Delete Space',
                            leading: Icons.delete_forever_rounded,
                            onTap: () => deleteSpace(spaceId: spaceId, spaceName: spaceName),
                          )
                        : NoWidget();
                  }
                }
                return LinearProgressIndicator(color: styler.textColor(faded: true));
              }),
        //
      ],
      noStyling: true,
      child: AppIcon(moreIcon, faded: true, size: 18),
    );
  }
}
