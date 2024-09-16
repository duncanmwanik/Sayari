// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart' as cfile;

import '../../../../__styling/variables.dart';
import '../../__styling/spacing.dart';
import '../../_providers/providers.dart';
import '../../_services/hive/local_storage_service.dart';
import '../../_widgets/buttons/buttons.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/loader.dart';
import '_helpers/download.dart';
import 'options.dart';
import 'viewer.dart';

class ImageFile extends StatelessWidget {
  const ImageFile(
    this.fileId,
    this.fileName, {
    super.key,
    this.images = const {},
    this.isOverview = false,
    this.radius,
    this.fit = BoxFit.cover,
    this.hoverColor,
    this.size,
    this.width,
    this.height,
    this.showOptions = true,
    this.showLoading = false,
    this.ignore = false,
    this.onPressed,
    this.selectedIndex = 0,
  });

  final String fileId;
  final String fileName;
  final bool isOverview;
  final bool showOptions;
  final bool showLoading;
  final bool ignore;
  final double? size;
  final double? width;
  final double? height;
  final double? radius;
  final BoxFit? fit;
  final Color? hoverColor;
  final Function()? onPressed;
  final Map images;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    bool isLocal = fileBox.containsKey(fileId);
    bool isValid = fileId.isNotEmpty && fileName.isNotEmpty;

    return SizedBox(
      height: height ?? size,
      width: width ?? size,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          //
          // if image is valid ----------
          //
          if (isValid)
            // for images still available in local filebox
            isLocal
                ? AppButton(
                    onPressed: onPressed ?? (ignore ? null : () => showImageViewer(images: images, selectedIndex: selectedIndex)),
                    hoverColor: hoverColor,
                    borderRadius: 8,
                    padding: EdgeInsets.zero,
                    noStyling: true,
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
                                    image: DecorationImage(image: MemoryImage(bytes), fit: fit)),
                              );
                            }
                          }
                          return Center(child: AppLoader());
                        }),
                  )
                //
                // for uploaded images cached from database
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
                                  onPressed:
                                      onPressed ?? (ignore ? null : () => showImageViewer(images: images, selectedIndex: selectedIndex)),
                                  hoverColor: hoverColor,
                                  borderRadius: 8,
                                  padding: EdgeInsets.zero,
                                  noStyling: true,
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
                                              child: Image.memory(
                                                bytes!,
                                                fit: fit,
                                              ),
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
                      // for loading process
                      return AppButton(
                        borderRadius: radius ?? borderRadiusSmall,
                        padding: EdgeInsets.zero,
                        child: Container(
                          padding: paddingS(),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius ?? borderRadiusSmall)),
                          child: Center(child: CircularProgressIndicator(color: styler.appColor(2), strokeWidth: 2)),
                        ),
                      );
                    }),
          //
          // if image is invalid ----------
          //
          if (!isValid)
            AppButton(
              borderRadius: radius ?? borderRadiusSmall,
              padding: EdgeInsets.zero,
              child: Container(
                padding: paddingS(),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius ?? borderRadiusSmall)),
                child: showLoading
                    ? Center(child: CircularProgressIndicator(color: styler.appColor(2), strokeWidth: 2))
                    : AppIcon(Icons.image, extraFaded: true),
              ),
            ),
          //
          // image options ----------
          //
          if (!isOverview && !state.views.isChat() && showOptions)
            Align(alignment: Alignment.bottomRight, child: FileOptions(fileId, fileName)),
          //
        ],
      ),
    );
  }
}
