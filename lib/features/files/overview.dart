import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';

import '../../../../__styling/variables.dart';
import '../../__styling/spacing.dart';
import '../../_models/item.dart';
import '../../_providers/providers.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/loader.dart';
import '../../_widgets/others/text.dart';
import '../_notes/items/actions.dart';
import '_helpers/download.dart';
import '_helpers/helper.dart';
import 'viewer.dart';

class ImageOverview extends StatelessWidget {
  const ImageOverview({super.key, this.item = const Item(), this.isInput = false});

  final Item item;
  final bool isInput;

  @override
  Widget build(BuildContext context) {
    String fileId = item.exists() ? item.coverId() : state.input.data['w'] ?? '';
    String fileName = item.exists() ? item.coverName() : state.input.data[fileId] ?? '';

    return Visibility(
      visible: fileId.isNotEmpty,
      child: SizedBox(
        height: isInput ? 300 : 150,
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
                                  borderRadius: 0,
                                  padding: EdgeInsets.zero,
                                  noStyling: !isInput,
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
                                                    topLeft: isInput ? Radius.zero : Radius.circular(borderRadiusSmall - 3),
                                                    topRight: isInput ? Radius.zero : Radius.circular(borderRadiusSmall - 3),
                                                    bottomLeft: Radius.zero,
                                                    bottomRight: Radius.zero,
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
                          padding: paddingS(),
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
                        padding: paddingL(),
                        child: AppText(
                          text: fileName,
                          textAlign: TextAlign.center,
                          weight: FontWeight.w600,
                          faded: true,
                        ),
                      )),
                    ),
                  ),
            // remove note pinned file
            if (isInput)
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: AppButton(
                    onPressed: () => state.input.remove('w'),
                    noStyling: true,
                    isSquare: true,
                    child: AppIcon(Icons.cancel, tiny: true, extraFaded: true),
                  ),
                ),
              ),
            // pinned icon
            if (!isInput)
              Align(
                alignment: Alignment.topRight,
                child: ItemActions(item: item),
              ),
            // /
          ],
        ),
      ),
    );
  }
}
