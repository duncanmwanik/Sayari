// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart' as cfile;

import '../../../../__styling/variables.dart';
import '../../__styling/spacing.dart';
import '../../_services/hive/local_storage_service.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/loader.dart';
import '_helpers/download.dart';
import 'image_viewer.dart';
import 'options.dart';

class ImageFile extends StatelessWidget {
  const ImageFile(
    this.fileId,
    this.fileName,
    this.images, {
    super.key,
    this.isOverview = false,
    this.radius,
    this.size,
    this.isLinks = false,
  });

  final String fileId;
  final String fileName;
  final bool isOverview;
  final bool isLinks;
  final double? size;
  final double? radius;
  final Map images;

  @override
  Widget build(BuildContext context) {
    bool isLocal = fileBox.containsKey(fileId);
    double imageSize = size ?? (isLinks ? 50 : (isOverview ? 40 : 80));

    return SizedBox(
      height: imageSize,
      width: imageSize,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          //
          //
          //
          if (fileId.isNotEmpty)
            isLocal
                ? AppButton(
                    onPressed: isLinks ? null : () => showImageViewer(images: images),
                    borderRadius: 8,
                    padding: EdgeInsets.zero,
                    noStyling: true,
                    tooltip: isOverview ? fileName : null,
                    child: FutureBuilder(
                        future: kIsWeb ? Future.delayed(Duration.zero, () => fileBox.get(fileId)) : io.File(fileBox.get(fileId)).readAsBytes(),
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
                                      fit: BoxFit.cover,
                                    )),
                              );
                            }
                          }
                          return Center(child: AppLoader());
                        }),
                  )
                : FutureBuilder(
                    future: getCachedFile(fileId: fileId, fileName: fileName),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return AppIcon(Icons.question_mark_rounded, color: styler.appColor(0.5));
                        } else if (snapshot.hasData) {
                          cfile.File? file = snapshot.data;

                          return file != null
                              ? AppButton(
                                  onPressed: isLinks ? null : () => showImageViewer(images: images),
                                  borderRadius: 8,
                                  padding: EdgeInsets.zero,
                                  noStyling: true,
                                  tooltip: isOverview ? fileName : null,
                                  child: FutureBuilder(
                                      future: file.readAsBytes(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.done) {
                                          if (snapshot.hasError) {
                                            return AppIcon(Icons.question_mark_rounded, faded: true);
                                          } else if (snapshot.hasData) {
                                            var bytes = snapshot.data;

                                            return ClipRRect(
                                              borderRadius: BorderRadius.circular(radius ?? borderRadiusSmall),
                                              child: Image.memory(bytes!, fit: BoxFit.fitWidth),
                                            );
                                          }
                                        }
                                        return Center(child: AppLoader());
                                      }),
                                )
                              : AppIcon(Icons.image_outlined, extraFaded: true);
                        }
                      }
                      //
                      //
                      return AppButton(
                        borderRadius: radius ?? borderRadiusSmall,
                        padding: EdgeInsets.zero,
                        child: Container(
                          padding: itemPaddingSmall(),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius ?? borderRadiusSmall)),
                          child: Center(child: CircularProgressIndicator(color: styler.appColor(2), strokeWidth: 2)),
                        ),
                      );
                    }),
          //
          //
          //
          if (fileId.isEmpty)
            AppButton(
              borderRadius: radius ?? borderRadiusSmall,
              padding: EdgeInsets.zero,
              child: Container(
                padding: itemPaddingSmall(),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius ?? borderRadiusSmall)),
                child: AppIcon(Icons.image, extraFaded: true),
              ),
            ),
          //
          //
          //
          if (!isOverview && !isLinks) Align(alignment: Alignment.bottomRight, child: FileOptions(fileId, fileName)),
          //
          //
          //
        ],
      ),
    );
  }
}
