// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:io' as io;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../__styling/variables.dart';
import '../../__styling/spacing.dart';
import '../../_providers/providers.dart';
import '../../_services/firebase/storage.dart';
import '../../_services/hive/local_storage_service.dart';
import '../../_widgets/buttons/buttons.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/loader.dart';
import '../_spaces/_helpers/common.dart';
import 'options.dart';
import 'viewer.dart';

class ImageFile extends StatelessWidget {
  const ImageFile(
    this.fileId,
    this.fileName,
    this.images, {
    super.key,
    this.isOverview = false,
    this.isEmbed = false,
    this.radius,
    this.size,
    this.width,
    this.height,
    this.isLinks = false,
    this.showOptions = true,
  });

  final String fileId;
  final String fileName;
  final bool isOverview;
  final bool isEmbed;
  final bool isLinks;
  final bool showOptions;
  final double? size;
  final double? width;
  final double? height;
  final double? radius;
  final Map images;

  @override
  Widget build(BuildContext context) {
    bool isLocal = 1 == 0;
    // bool isLocal = fileBox.containsKey(fileId);
    // printThis('image-$fileId-$fileName-$isLocal');
    // printThis(fileBox.get(fileId));
    double imageSize = size ?? (isOverview ? 40 : 80);

    return SizedBox(
      height: height ?? (isEmbed ? 200 : imageSize),
      width: width ?? (isEmbed ? double.infinity : imageSize),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          // the image itself
          if (fileId.isNotEmpty)
            //
            // for images still available in local filebox
            isLocal
                ? AppButton(
                    onPressed: isLinks ? null : () => showImageViewer(images: images),
                    hoverColor: isEmbed ? transparent : null,
                    borderRadius: 8,
                    padding: EdgeInsets.zero,
                    noStyling: true,
                    // tooltip: isOverview ? fileName : null, // gives height pos error
                    child: FutureBuilder(
                        future:
                            kIsWeb ? Future.delayed(Duration.zero, () => fileBox.get(fileId)) : io.File(fileBox.get(fileId)).readAsBytes(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasError) {
                              return AppIcon(Icons.question_mark_rounded, faded: true);
                            } else if (snapshot.hasData) {
                              var bytes = snapshot.data as Uint8List;

                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radius ?? borderRadiusSmall),
                                    image: DecorationImage(
                                      image: MemoryImage(bytes),
                                      fit: isEmbed ? BoxFit.fitHeight : BoxFit.cover,
                                    )),
                              );
                            }
                          }
                          return Center(child: AppLoader());
                        }),
                  )
                //
                // for uploaded images cached from database
                : ExtendedImage.network(
                    cloudStorage.getFileUrl(db: 'spaces', cloudFilePath: '${liveSpace()}/$fileName') as String,
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.fill,
                    cache: true,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
          //
          // for missing/no image
          if (fileId.isEmpty)
            AppButton(
              borderRadius: radius ?? borderRadiusSmall,
              padding: EdgeInsets.zero,
              child: Container(
                padding: paddingS(),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius ?? borderRadiusSmall)),
                child: AppIcon(Icons.image, extraFaded: true),
              ),
            ),
          //
          // image options
          if (!isOverview && !isLinks && !state.views.isChat() && showOptions)
            Align(alignment: Alignment.topRight, child: FileOptions(fileId, fileName)),
          //
        ],
      ),
    );
  }
}
