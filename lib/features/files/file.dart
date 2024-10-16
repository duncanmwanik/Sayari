// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../_services/hive/local_storage_service.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/text.dart';
import '_helpers/helper.dart';
import 'options.dart';
import 'var/variables.dart';

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
            padding: noPadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // extension
                Container(
                  decoration: BoxDecoration(
                    color: fileTypeColors[getfileExtension(fileName)] ?? Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadiusTiny),
                      bottomLeft: Radius.circular(borderRadiusTiny),
                    ),
                  ),
                  padding: padS(),
                  child: AppText(text: getfileExtension(fileName).toUpperCase(), color: white, size: tiny),
                ),
                // name
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
