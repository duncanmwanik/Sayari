import 'package:flutter/material.dart';

import '../../_models/item.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '_helpers/helper.dart';
import 'file.dart';
import 'image.dart';

class FileList extends StatelessWidget {
  const FileList({super.key, required this.item, this.isOverview = false});

  final Item item;
  final bool isOverview;

  @override
  Widget build(BuildContext context) {
    Map fileData = item.files();
    List filesIds = fileData.keys.toList().where((key) => !isImageFile(fileData[key])).toList();
    List imageIds = fileData.keys.toList().where((key) => isImageFile(fileData[key])).toList();
    Map images = {...fileData};
    images.removeWhere((key, value) => !imageIds.contains(key));

    return Visibility(
      visible: item.hasFiles(),
      child: Padding(
        padding: padM('t'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // images
            if (imageIds.isNotEmpty)
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //
                  Flexible(
                    child: GridView.extent(
                      shrinkWrap: true,
                      maxCrossAxisExtent: isOverview ? 40 : 80,
                      mainAxisSpacing: tinyWidth(),
                      crossAxisSpacing: tinyWidth(),
                      children: List.generate(imageIds.length > 4 && isOverview ? 4 : imageIds.length, (index) {
                        String fileId = imageIds[index];
                        String fileName = fileData[fileId];

                        return ImageFile(
                          fileId,
                          fileName,
                          images: images,
                          isOverview: isOverview,
                          height: isOverview ? 30 : 80,
                          width: isOverview ? 30 : 80,
                          radius: isOverview ? borderRadiusTiny : null,
                          selectedIndex: index,
                        );
                      }),
                    ),
                  ),
                  // overview hidden image count
                  if (imageIds.length > 4 && isOverview)
                    Padding(
                      padding: padM(),
                      child: AppText(text: '+ ${imageIds.length - 4}', faded: true),
                    ),
                  //
                ],
              ),
            // Other files
            if (filesIds.isNotEmpty && imageIds.isNotEmpty) sph(),
            if (filesIds.isNotEmpty)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // input
                  if (!isOverview)
                    Flexible(
                      child: Wrap(
                        spacing: isOverview ? tinyWidth() : smallWidth(),
                        runSpacing: isOverview ? tinyWidth() : smallWidth(),
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: List.generate(filesIds.length > 5 && isOverview ? 5 : filesIds.length, (index) {
                          String fileId = filesIds[index];
                          String fileName = fileData[fileId];

                          return FileItem(fileId: fileId, fileName: fileName, isOverview: isOverview);
                        }),
                      ),
                    ),
                  // overview
                  if (isOverview)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcon(Icons.folder, size: small, faded: true),
                        tpw(),
                        Flexible(
                            child: AppText(
                          text: '${filesIds.length} file${filesIds.length > 1 ? 's' : ''} attached',
                          size: tiny,
                          faded: true,
                        )),
                      ],
                    ),
                  //
                ],
              ),
            //
          ],
        ),
      ),
    );
  }
}
