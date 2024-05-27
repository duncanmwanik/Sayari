import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/misc.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/strings.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/forms/input.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../files/_helpers/upload.dart';
import '../../files/image.dart';
import 'header.dart';

class LinkUserName extends StatefulWidget {
  const LinkUserName({super.key, required this.username});

  final String username;

  @override
  State<LinkUserName> createState() => _HabitWeekState();
}

class _HabitWeekState extends State<LinkUserName> {
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    setState(() {
      titleController.text = widget.username;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String fileId = state.input.data['wuf'] ?? '';
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
                      state.input.update(action: 'add', key: 'wuf', value: fileMap['fileId']);
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
              LinksHeader(),
              //
            ],
          ),
          //
          sph(),
          //
          AppButton(
            borderRadius: borderRadiusSmall,
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                //
                AppIcon(Icons.alternate_email, tiny: true, faded: true),
                //
                Expanded(
                  child: DataInput(
                    hintText: 'Link eg: https://sayari.com/fun ...',
                    controller: titleController,
                    contentPadding: EdgeInsets.all(10),
                    fontSize: normal,
                    color: transparent,
                  ),
                ),
                //
                tpw(),
                //
                AppButton(
                  onPressed: () async => await copyToClipboard('$sayariDefaultPath/${titleController.text.trim()}', desc: 'link'),
                  noStyling: true,
                  child: AppIcon(Icons.copy, size: 18),
                ),
                //
              ],
            ),
          ),
          //
          tph(),
          //
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: AppText(text: '$sayariDefaultPath/${titleController.text.trim()}', faded: true),
          ),
          //
        ],
      ),
    );
  }
}
