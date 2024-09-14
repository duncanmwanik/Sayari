// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';

import '../../__styling/variables.dart';
import '../../_widgets/buttons/buttons.dart';
import '../../_widgets/menu/menu_item.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/loader.dart';
import '../../_widgets/others/others/other_widgets.dart';
import '../files/_helpers/download.dart';
import '../files/_helpers/dp.dart';
import '../files/viewer.dart';
import '_helpers/set_user_data.dart';

class UserDp extends StatelessWidget {
  const UserDp(
      {super.key, this.isTiny = false, this.noViewer = false, this.userId, this.tooltip, this.size, this.onPressed, this.menuItems});

  final bool isTiny;
  final bool noViewer;
  final String? userId;
  final String? tooltip;
  final double? size;
  final Function()? onPressed;
  final List<Widget>? menuItems;

  @override
  Widget build(BuildContext context) {
    double radius = size ?? (isTiny ? 12 : 60);

    return FutureBuilder(
        future: getCachedFile(db: 'users', cloudFilePath: '${userId ?? liveUser()}/dp.jpg', fileId: 'dp'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              File? file = snapshot.data;

              return file != null
                  ? AppButton(
                      tooltip: tooltip,
                      onPressed: menuItems != null
                          ? null
                          : onPressed ??
                              () => noViewer
                                  ? showImageViewer(
                                      images: {'dp': 'dp.jpg'},
                                      onDownload: () async => await downloadFile(
                                        db: 'users',
                                        fileId: 'dp',
                                        fileName: 'dp.jpg',
                                        cloudFilePath: '${liveUser()}/dp.jpg',
                                        downloadPath: 'dp.jpg',
                                      ),
                                    )
                                  : null,
                      menuItems: menuItems ??
                          (isTiny || noViewer
                              ? []
                              : [
                                  //
                                  MenuItem(onTap: () async => await chooseUserDp(), label: 'Edit', leading: Icons.edit),
                                  //
                                  MenuItem(
                                    onTap: () async => await showImageViewer(
                                      images: {'dp': 'dp.jpg'},
                                      onDownload: () async => await downloadFile(
                                        db: 'users',
                                        fileId: 'dp',
                                        fileName: 'dp.jpg',
                                        cloudFilePath: '${liveUser()}/' 'dp.jpg',
                                        downloadPath: 'dp.jpg',
                                      ),
                                    ),
                                    label: 'View',
                                    leading: Icons.image_outlined,
                                  ),
                                  //
                                ]),
                      isRound: true,
                      padding: EdgeInsets.all(isTiny ? 0 : 3),
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
                              radius: radius + 1,
                              child: Center(child: AppLoader()),
                            );
                          }),
                    )
                  : Center(child: AppLoader());
            }
          }
          return AppButton(
            tooltip: tooltip,
            onPressed: menuItems != null ? null : onPressed,
            menuItems: menuItems,
            isRound: true,
            padding: EdgeInsets.all(isTiny ? 3 : 3),
            child: CircleAvatar(
              backgroundColor: transparent,
              radius: radius,
              child: AppLoader(color: styler.appColor(2), size: isTiny ? 18 : 40, stroke: isTiny ? 2 : 4),
            ),
          );
        });
  }
}
