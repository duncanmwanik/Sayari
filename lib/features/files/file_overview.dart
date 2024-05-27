import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';

import '../../../../__styling/variables.dart';
import '../../__styling/spacing.dart';
import '../../_models/item.dart';
import '../../_providers/providers.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/items/pinned.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/loader.dart';
import '../../_widgets/others/others/other_widgets.dart';
import '../../_widgets/others/text.dart';
import '_helpers/download.dart';
import '_helpers/helper.dart';
import 'image_viewer.dart';

class ImageOverview extends StatelessWidget {
  const ImageOverview({super.key, this.item, this.isInput = false});

  final Item? item;
  final bool isInput;

  @override
  Widget build(BuildContext context) {
    String fileId = item != null ? item!.coverId() : state.input.data['w'] ?? '';
    String fileName = item != null ? item!.coverName() : state.input.data[fileId] ?? '';

    return fileId.isNotEmpty
        ? Padding(
            padding: itemPaddingSmall(top: isInput),
            child: SizedBox(
              height: 150,
              width: double.maxFinite,
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  //
                  isImageFile(fileName)
                      ? FutureBuilder(
                          future: getCachedFile(fileId: fileId, fileName: fileName),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasError) {
                                return AppIcon(Icons.image_outlined, color: styler.appColor(0.5));
                              } else if (snapshot.hasData) {
                                File? file = snapshot.data;

                                return file != null
                                    ? AppButton(
                                        onPressed: isInput ? () => showImageViewer(images: {fileId: fileName}) : null,
                                        borderRadius: borderRadiusMediumSmall,
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

                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(borderRadiusSmall - 3),
                                                          topRight: Radius.circular(borderRadiusSmall - 3),
                                                          bottomLeft: isInput ? Radius.circular(borderRadiusSmall) : Radius.zero,
                                                          bottomRight: isInput ? Radius.circular(borderRadiusSmall) : Radius.zero,
                                                        ),
                                                        image: DecorationImage(image: MemoryImage(bytes!), fit: BoxFit.fill)),
                                                  );
                                                }
                                              }
                                              return Center(child: AppLoader(color: styler.appColor(2)));
                                            }),
                                      )
                                    : AppIcon(Icons.image_outlined, color: styler.appColor(0.5));
                              }
                            }
                            return AppButton(
                              borderRadius: 8,
                              padding: EdgeInsets.zero,
                              child: Container(
                                padding: itemPaddingSmall(),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadiusSmall)),
                                child: Center(child: AppLoader(color: styler.appColor(2))),
                              ),
                            );
                          })
                      : AppButton(
                          onPressed: isInput ? () {} : null,
                          borderRadius: borderRadiusMediumSmall,
                          padding: EdgeInsets.zero,
                          noStyling: true,
                          child: Container(
                            decoration: BoxDecoration(
                              color: styler.appColor(styler.isDark ? 0.5 : 0.8),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(borderRadiusSmall - 3),
                                topRight: Radius.circular(borderRadiusSmall - 3),
                                bottomLeft: isInput ? Radius.circular(borderRadiusSmall) : Radius.zero,
                                bottomRight: isInput ? Radius.circular(borderRadiusSmall) : Radius.zero,
                              ),
                            ),
                            child: Center(
                                child: Padding(
                              padding: itemPaddingLarge(),
                              child: AppText(text: fileName, textAlign: TextAlign.center),
                            )),
                          ),
                        ),
                  //
                  if (isInput)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: AppButton(
                          onPressed: () => state.input.update(action: 'remove', key: 'w'),
                          child: AppIcon(Icons.delete, faded: true, size: 14),
                        ),
                      ),
                    ),
                  //
                  if (item != null && !isInput)
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: PinnedIcon(item: item!),
                      ),
                    ),
                  // /
                ],
              ),
            ),
          )
        : NoWidget();
  }
}
