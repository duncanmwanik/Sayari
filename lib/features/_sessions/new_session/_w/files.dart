import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_providers/common/input.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../../../files/_helpers/upload.dart';
import '../../../files/file_list.dart';

class Files extends StatelessWidget {
  const Files({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Row(
            children: [
              //
              AppIcon(Icons.attach_file_rounded, faded: true, size: 18),
              spw(),
              //
              AppButton(
                  onPressed: () async => await getFilesToUpload(),
                  child: Row(
                    children: [
                      AppIcon(
                        Icons.add_rounded,
                        size: 16,
                      ),
                      tpw(),
                      AppText(
                        text: 'Attach Files',
                      ),
                    ],
                  )),
              //
            ],
          ),
          //
          sph(),
          //
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: FileList(),
          ),
          //
        ],
      );
    });
  }
}
