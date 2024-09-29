// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../__styling/variables.dart';
import '../../_helpers/debug.dart';
import '../../_services/hive/local_storage_service.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/loader.dart';
import '../../_widgets/others/others/other.dart';
import '../files/_helpers/cached.dart';
import '../files/_helpers/download.dart';
import '../files/viewer.dart';
import '_helpers/helpers.dart';
import 'dp_menu.dart';

class UserDp extends StatelessWidget {
  const UserDp(
      {super.key,
      this.isTiny = true,
      this.noViewer = false,
      this.userId,
      this.tooltip,
      this.size,
      this.onPressed,
      this.menuItems,
      this.hoverColor});

  final bool isTiny;
  final bool noViewer;
  final String? userId;
  final String? tooltip;
  final double? size;
  final Function()? onPressed;
  final List<Widget>? menuItems;
  final Color? hoverColor;

  @override
  Widget build(BuildContext context) {
    double radius = size ?? (isTiny ? 12 : 60);

    return ValueListenableBuilder(
        valueListenable: userInfoBox.listenable(),
        builder: (context, box, widget) {
          bool hasDp = hasUserDp();
          printThis(box.toMap());

          return hasDp
              ? FutureBuilder(
                  future: getCachedFile(db: 'users', cloudFilePath: '${userId ?? liveUser()}/${userDp()}', fileId: userDpId()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        File? file = snapshot.data;

                        return file != null
                            ? AppButton(
                                onPressed: onPressed ??
                                    (noViewer
                                        ? null
                                        : () => showImageViewer(
                                              images: {userDpId(): userDp()},
                                              onDownload: () async => await downloadFile(
                                                db: 'users',
                                                fileId: userDpId(),
                                                fileName: userDp(),
                                                cloudFilePath: '${liveUser()}/${userDp()}',
                                                downloadPath: userDp(),
                                              ),
                                            )),
                                height: radius,
                                width: radius,
                                color: hoverColor,
                                padding: noPadding,
                                hoverColor: hoverColor,
                                menuItems: noViewer ? [] : menuItems ?? dpMenu(),
                                isRound: true,
                                child: FutureBuilder(
                                    future: file.readAsBytes(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return CircleAvatar(
                                            backgroundColor: transparent,
                                            radius: radius,
                                            child: AppIcon(Icons.person, size: isTiny ? 16 : 32, faded: true),
                                          );
                                        } else if (snapshot.hasData) {
                                          var bytes = snapshot.data;

                                          return CircleAvatar(
                                            backgroundImage: MemoryImage(bytes!),
                                            radius: radius,
                                            child: isTiny || noViewer ? NoWidget() : AppIcon(Icons.edit, size: 16, faded: true),
                                          );
                                        }
                                      }

                                      return CircleAvatar(
                                        backgroundColor: transparent,
                                        radius: radius,
                                        child: AppLoader(),
                                      );
                                    }),
                              )
                            : Center(child: AppLoader());
                      }
                    }

                    return AppButton(
                      tooltip: tooltip,
                      onPressed: menuItems != null ? null : onPressed,
                      menuItems: noViewer ? [] : menuItems ?? dpMenu(),
                      height: radius,
                      width: radius,
                      isRound: true,
                      dryWidth: true,
                      padding: noPadding,
                      child: CircleAvatar(backgroundColor: transparent, radius: radius, child: AppLoader()),
                    );
                  })
              : AppButton(
                  tooltip: tooltip,
                  onPressed: menuItems != null ? null : onPressed,
                  menuItems: noViewer ? [] : menuItems ?? dpMenu(),
                  height: radius,
                  width: radius,
                  isRound: true,
                  dryWidth: true,
                  padding: noPadding,
                  child: CircleAvatar(
                    backgroundColor: transparent,
                    radius: radius,
                    child: AppIcon(Icons.person, size: isTiny ? 16 : 32, faded: true),
                  ),
                );
        });
  }
}
