import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../_providers/common/input.dart';
import '../../_widgets/others/text.dart';
import '_helpers/helper.dart';
import 'file.dart';
import 'image.dart';

class FileList extends StatelessWidget {
  const FileList({super.key, this.fileData, this.isOverview = false});

  final Map? fileData;
  final bool isOverview;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      Map fileData_ = fileData ?? getFiles(input.data);
      List filesIds = fileData_.keys.toList().where((element) => !isImageFile(fileData_[element])).toList();
      List imageIds = fileData_.keys.toList().where((element) => isImageFile(fileData_[element])).toList();
      Map images = {...fileData_};
      images.removeWhere((key, value) => !imageIds.contains(key));

      return Visibility(
        visible: fileData_.isNotEmpty,
        child: Padding(
          padding: itemPaddingMedium(bottom: true),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: isOverview ? tinyWidth() : smallWidth(),
                      runSpacing: isOverview ? tinyWidth() : smallWidth(),
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: List.generate(imageIds.length > 6 && isOverview ? 6 : imageIds.length, (index) {
                        String fileId = imageIds[index];
                        String fileName = fileData_[fileId];

                        return ImageFile(fileId, fileName, images, isOverview: isOverview);
                      }),
                    ),
                  ),
                  if (imageIds.length > 6 && isOverview) AppText(text: '+ ${imageIds.length - 6}', faded: true),
                ],
              ),
              sph(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: isOverview ? tinyWidth() : smallWidth(),
                      runSpacing: isOverview ? tinyWidth() : smallWidth(),
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: List.generate(filesIds.length > 6 && isOverview ? 6 : filesIds.length, (index) {
                        String fileId = filesIds[index];
                        String fileName = fileData_[fileId];

                        return FileItem(fileId: fileId, fileName: fileName, isOverview: isOverview);
                      }),
                    ),
                  ),
                  if (filesIds.length > 6 && isOverview) AppText(text: '+ ${filesIds.length - 6}', faded: true),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
