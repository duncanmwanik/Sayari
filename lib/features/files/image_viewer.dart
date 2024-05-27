import 'dart:io' as io;
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:photo_view/photo_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_services/hive/local_storage_service.dart';
import '../../_variables/navigation.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/loader.dart';
import '_helpers/download.dart';

Future<void> showImageViewer({required Map images, Function()? onDownload}) async {
  await showModalBottomSheet(
      context: navigatorState.currentContext!,
      isScrollControlled: true,
      enableDrag: false,
      useSafeArea: true,
      elevation: 0,
      backgroundColor: transparent,
      constraints: BoxConstraints(minWidth: 100.w),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Viewer(images: images, onDownload: onDownload),
        );
      });
}

class Viewer extends StatefulWidget {
  const Viewer({super.key, required this.images, this.onDownload});

  final Map images;
  final Function()? onDownload;

  @override
  State<Viewer> createState() => _ViewerState();
}

class _ViewerState extends State<Viewer> {
  int selected = 0;
  double scale = 1;
  var quarterTurns = 0;
  PhotoViewController photoViewController = PhotoViewController(initialScale: 1);

  void rotate90Degrees(String direction) {
    if (direction == 'right') {
      quarterTurns = quarterTurns == 3 ? 0 : quarterTurns + 1;
    } else {
      quarterTurns = quarterTurns == 0 ? 3 : quarterTurns - 1;
    }
    photoViewController.rotation = math.pi / 2 * quarterTurns;
  }

  void zoom(String direction) {
    if (direction == 'in') {
      scale = photoViewController.scale ?? 1;
      photoViewController.scale = scale + 0.2;
    } else if (direction == 'out') {
      scale = photoViewController.scale ?? 1;
      scale = scale > 0.21 ? scale - 0.2 : scale;
      photoViewController.scale = scale;
    } else {
      photoViewController.reset();
    }
  }

  @override
  void dispose() {
    photoViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String fileId = widget.images.keys.toList()[selected];
    String fileName = widget.images[fileId];
    bool isLocal = fileBox.containsKey(fileId);

    return Stack(
      children: [
        //
        // image viewer ------------------------------ start
        //
        isLocal
            ? FutureBuilder(
                future: kIsWeb ? Future.delayed(Duration.zero, () => fileBox.get(fileId)) : io.File(fileBox.get(fileId)).readAsBytes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(child: AppLoader(size: 100, color: styler.accentColor()));
                    } else if (snapshot.hasData) {
                      var bytes = snapshot.data as Uint8List;

                      return PhotoView(
                        controller: photoViewController,
                        backgroundDecoration: BoxDecoration(color: transparent),
                        imageProvider: MemoryImage(bytes),
                      );
                    }
                  }
                  return Center(child: AppLoader(size: 100, color: styler.accentColor()));
                })
            : FutureBuilder(
                future: getCachedFile(fileId: fileId, fileName: fileName),
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
                                    return Center(child: AppLoader(size: 100, color: styler.accentColor()));
                                  } else if (snapshot.hasData) {
                                    var bytes = snapshot.data;

                                    return PhotoView(
                                      controller: photoViewController,
                                      backgroundDecoration: BoxDecoration(color: transparent),
                                      imageProvider: MemoryImage(bytes!),
                                    );
                                  }
                                }
                                return Center(child: AppLoader(size: 100, color: styler.accentColor()));
                              })
                          : AppIcon(Icons.image_outlined, size: 40, color: styler.appColor(0.5));
                    }
                  }
                  return AppButton(
                    borderRadius: 8,
                    padding: EdgeInsets.zero,
                    child: Container(
                      padding: itemPaddingSmall(),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadiusSmall)),
                      child: Center(child: CircularProgressIndicator(color: styler.appColor(2), strokeWidth: 2)),
                    ),
                  );
                }),
        //
        // image viewer ------------------------------ end
        //
        // options ------------------------------ start
        //
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: itemPadding(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // close viewer
                AppButton(
                  onPressed: () => popWhatsOnTop(),
                  isSquare: true,
                  color: styler.appColor(5),
                  textColor: white,
                  leading: closeIcon,
                ),
                //
                //
                Expanded(
                  child: Wrap(
                    spacing: mediumSmallWidth(),
                    runSpacing: smallHeight(),
                    alignment: WrapAlignment.end,
                    children: [
                      AppButton(
                        onPressed: () => zoom('in'),
                        isSquare: true,
                        color: styler.appColor(5),
                        textColor: white,
                        leading: Icons.add,
                      ),
                      AppButton(
                        onPressed: () => zoom('out'),
                        isSquare: true,
                        color: styler.appColor(5),
                        textColor: white,
                        leading: Icons.remove,
                      ),
                      AppButton(
                        onPressed: () => zoom('none'),
                        isSquare: true,
                        color: styler.appColor(5),
                        textColor: white,
                        leading: Icons.fullscreen,
                      ),
                      AppButton(
                        onPressed: () => rotate90Degrees('left'),
                        isSquare: true,
                        color: styler.appColor(5),
                        textColor: white,
                        leading: Icons.rotate_90_degrees_ccw_outlined,
                      ),
                      AppButton(
                        onPressed: () => rotate90Degrees('right'),
                        isSquare: true,
                        color: styler.appColor(5),
                        textColor: white,
                        leading: Icons.rotate_90_degrees_cw_outlined,
                      ),
                      AppButton(
                        onPressed: widget.onDownload ?? () => downloadFile(fileId: fileId, fileName: fileName),
                        isSquare: true,
                        color: styler.appColor(5),
                        textColor: white,
                        leading: Icons.download_outlined,
                      ),
                      if (!kIsWeb)
                        AppButton(
                          onPressed: () {},
                          isSquare: true,
                          color: styler.appColor(5),
                          textColor: white,
                          leading: Icons.open_in_new_rounded,
                        ),
                      //
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        //
        // options ------------------------------ end
        //
        // next/previous image ------------------------------ start
        //
        if (widget.images.length > 1)
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: itemPadding(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // previous
                  AppButton(
                    onPressed: () {
                      if (selected > 0) {
                        setState(() => selected -= 1);
                      }
                      photoViewController.reset();
                    },
                    iconSize: 30,
                    color: styler.appColor(0.5),
                    textColor: white,
                    leading: Icons.keyboard_arrow_left_rounded,
                  ),
                  // next
                  AppButton(
                    onPressed: () {
                      if (selected < widget.images.length - 1) {
                        setState(() => selected += 1);
                      }
                      photoViewController.reset();
                    },
                    iconSize: 30,
                    color: styler.appColor(0.5),
                    textColor: white,
                    leading: Icons.keyboard_arrow_right_rounded,
                  ),
                  //
                ],
              ),
            ),
          )
        // next/previous image ------------------------------ end
      ],
    );
  }
}
