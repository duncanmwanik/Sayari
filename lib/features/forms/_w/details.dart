import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/misc.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/strings.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../files/_helpers/upload.dart';
import '../../files/image.dart';
import 'header.dart';

class FormDetails extends StatefulWidget {
  const FormDetails({super.key});

  @override
  State<FormDetails> createState() => _HabitWeekState();
}

class _HabitWeekState extends State<FormDetails> {
  @override
  Widget build(BuildContext context) {
    String fileId = state.input.data['qf'] ?? '';
    String fileName = state.input.data[fileId] ?? '';

    return AppButton(
      borderRadius: borderRadiusMediumSmall,
      color: transparent,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              AppButton(
                onPressed: () async {
                  await getFilesToUpload(allowMultiple: false, imagesOnly: true).then((fileMap) {
                    if (fileMap.isNotEmpty) {
                      state.input.update(action: 'remove', key: fileId);
                      state.input.update(action: 'add', key: 'qf', value: fileMap['fileId']);
                    }
                  });
                },
                padding: EdgeInsets.all(3),
                borderRadius: borderRadiusCrazy,
                child: ImageFile(
                  fileId,
                  fileName,
                  {fileId: fileName},
                  isLinks: true,
                  radius: borderRadiusCrazy,
                  size: 80,
                ),
              ),
              //
              FormsHeader(),
              //
            ],
          ),
          //
          sph(),
          //
          AppButton(
            onPressed: () async => await copyToClipboard('$sayariDefaultPath/${state.input.itemId}', desc: 'link'),
            noStyling: true,
            child: Row(
              children: [
                Expanded(child: AppText(text: '$sayariDefaultPath/${state.input.itemId}', faded: true)),
                AppIcon(Icons.copy, size: 18, faded: true),
              ],
            ),
          ),
          //
          //
        ],
      ),
    );
  }
}
