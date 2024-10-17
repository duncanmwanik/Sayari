// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../_services/hive/local_storage_service.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/loader.dart';
import '../../_widgets/others/others/other.dart';
import '../files/_helpers/cached.dart';
import '_helpers/helpers.dart';
import 'dp_menu.dart';

class UserDp extends StatelessWidget {
  const UserDp({super.key, this.isTiny = true, this.userId, this.tooltip, this.size, this.onPressed, this.menuItems, this.hoverColor});

  final bool isTiny;
  final String? userId;
  final String? tooltip;
  final double? size;
  final Function()? onPressed;
  final List<Widget>? menuItems;
  final Color? hoverColor;

  @override
  Widget build(BuildContext context) {
    double radius = size ?? (isTiny ? 12 : 60);
    Widget errorWidget = AppIcon(Icons.person, size: isTiny ? 16 : 32, faded: true);

    return ValueListenableBuilder(
        valueListenable: userInfoBox.listenable(keys: ['p']),
        builder: (context, box, widget) {
          bool hasDp = hasUserDp();

          return AppButton(
            tooltip: tooltip,
            onPressed: menuItems != null ? null : onPressed,
            menuItems: onPressed == null ? menuItems ?? dpMenu() : null,
            height: radius,
            width: radius,
            isRound: true,
            dryWidth: true,
            padding: padS(),
            color: hoverColor,
            hoverColor: hoverColor,
            child: hasDp
                ? FutureBuilder(
                    future: getCachedFile(db: 'users', cloudFilePath: '${userId ?? liveUser()}/${userDp()}', fileId: userDpId()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          File? file = snapshot.data;

                          return file != null
                              ? FutureBuilder(
                                  future: file.readAsBytes(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      if (snapshot.hasError) {
                                        return CircleAvatar(backgroundColor: transparent, radius: radius, child: errorWidget);
                                      } else if (snapshot.hasData) {
                                        return CircleAvatar(
                                          backgroundImage: MemoryImage(snapshot.data!),
                                          backgroundColor: transparent,
                                          radius: radius,
                                          child: isTiny ? NoWidget() : AppIcon(Icons.edit, size: 16, faded: true),
                                        );
                                      }
                                    }

                                    return CircleAvatar(backgroundColor: transparent, radius: radius, child: AppLoader());
                                  })
                              : errorWidget;
                        }
                      }

                      return CircleAvatar(backgroundColor: transparent, radius: radius, child: AppLoader());
                    })

                // no dp
                : CircleAvatar(backgroundColor: transparent, radius: radius, child: errorWidget),
          );
        });
  }
}
