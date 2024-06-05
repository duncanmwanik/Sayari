import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/_common/misc.dart';
import '../../../../../_providers/providers.dart';
import '../../../../../_variables/strings.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../files/_helpers/upload.dart';
import '../../../../files/image.dart';

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
          // sph(),
          // //
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     //
          //     AppIcon(Icons.alternate_email, tiny: true, faded: true),
          //     //
          //     Flexible(
          //       child: DataInput(
          //         hintText: 'Link eg: https://sayari.com/fun ...',
          //         controller: titleController,
          //         contentPadding: EdgeInsets.all(10),
          //         fontSize: normal,
          //         color: transparent,
          //       ),
          //     ),
          //     //
          //   ],
          // ),
          //
          tph(),
          //
          AppButton(
            onPressed: () async =>
                await copyToClipboard('$sayariDefaultPath/${titleController.text.trim()}', desc: 'link'),
            noStyling: true,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.alternate_email, size: medium),
                tpw(),
                Flexible(child: AppText(text: '$sayariDefaultPath/${titleController.text.trim()}', faded: true)),
              ],
            ),
          ),
          //
          tph(),
          //
          AppButton(
            onPressed: () => context.push('/links/1715104863369'),
            noStyling: true,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(text: 'Preview', size: small),
                spw(),
                AppIcon(Icons.open_in_new_rounded, size: small, faded: true),
              ],
            ),
          ),
          //
        ],
      ),
    );
  }
}
