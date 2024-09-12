// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_services/hive/local_storage_service.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/others/text.dart';
import '_helpers/helper.dart';
import '_vars/variables.dart';
import 'options.dart';

// TODOs: Verify path exists
// TODOs: Get web path

class FileItem extends StatelessWidget {
  const FileItem({super.key, required this.fileId, required this.fileName, this.bgColor, this.isOverview = false});

  final String fileId;
  final String fileName;
  final String? bgColor;
  final bool isOverview;

  @override
  Widget build(BuildContext context) {
    bool isDownloading = false;

    return ValueListenableBuilder(
        valueListenable: fileBox.listenable(),
        builder: (context, box, widget) {
          return AppButton(
            onPressed: () async => openFile(fileId),
            tooltip: isOverview ? fileName : null,
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                AppButton(
                  borderRadius: borderRadiusTiny,
                  color: fileTypeColors[getfileExtension(fileName)] ?? Colors.blue,
                  child: AppText(text: getfileExtension(fileName).toUpperCase(), size: tiny),
                ),
                // for input sheets
                if (!isOverview) spw(),
                if (!isOverview) Flexible(child: AppText(text: fileName)),
                if (!isOverview) spw(),
                //
                if (!isOverview && isDownloading) SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 3)),
                //
                if (!isOverview) FileOptions(fileId, fileName),
                //
              ],
            ),
          );
        });
  }
}
