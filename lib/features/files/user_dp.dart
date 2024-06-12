// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';

import '../../__styling/variables.dart';
import '../../_helpers/user/set_user_data.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/abcs/menu/menu_item.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/loader.dart';
import '../../_widgets/others/others/other_widgets.dart';
import '../settings/settings_sheet.dart';
import '_helpers/download.dart';
import '_helpers/upload.dart';
import 'image_viewer.dart';

class UserDp extends StatelessWidget {
  const UserDp({super.key, this.isTiny = false, this.viewOnly = false, this.userId, this.size, this.onPressed});

  final bool isTiny;
  final bool viewOnly;
  final String? userId;
  final double? size;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    double radius = size ?? (isTiny ? 14 : 60);

    return AppButton(
      tooltip: viewOnly ? null : (isTiny ? 'Account & Settings' : null),
      onPressed: viewOnly ? () {} : (isTiny ? () => showSettingsBottomSheet() : null),
      isRound: true,
      padding: EdgeInsets.all(isTiny ? 0 : 3),
      child: CircleAvatar(
        backgroundColor: transparent,
        radius: radius,
        child: Image.asset('assets/images/love.png'),
      ),
    );

    return FutureBuilder(
        future: getCachedFile(db: 'users', cloudFilePath: '${userId ?? liveUser()}/dp.jpg', fileId: 'dp'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              File? file = snapshot.data;

              return file != null
                  ? AppButton(
                      tooltip: isTiny ? 'Account & Settings' : null,
                      onPressed: onPressed ??
                          () => isTiny
                              ? showSettingsBottomSheet()
                              : viewOnly
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
                      menuItems: isTiny || viewOnly
                          ? []
                          : [
                              //
                              MenuItem(onTap: () async => await chooseUserDp(), label: 'Edit', iconData: Icons.edit),
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
                                iconData: Icons.image_outlined,
                              ),
                              //
                            ],
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
                                  child: isTiny || viewOnly ? NoWidget() : AppIcon(Icons.edit, size: 16, faded: true),
                                );
                              }
                            }
                            return CircleAvatar(
                              backgroundColor: transparent,
                              radius: radius,
                              child: Center(child: AppLoader()),
                            );
                          }),
                    )
                  : Center(child: AppLoader());
            }
          }
          return AppButton(
            tooltip: isTiny ? 'Account & Settings' : null,
            // onPressed: onPressed ?? () => showSettingsBottomSheet(),
            onPressed: () async => await chooseUserDp(),
            isRound: true,
            padding: EdgeInsets.all(isTiny ? 0 : 3),
            child: CircleAvatar(
              backgroundColor: transparent,
              radius: radius,
              child: AppLoader(color: styler.appColor(2), size: isTiny ? 18 : 40, stroke: isTiny ? 2 : 4),
            ),
          );
        });
  }
}
