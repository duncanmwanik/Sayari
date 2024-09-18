import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/input.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/svg.dart';
import '../../../_widgets/others/text.dart';
import '../../_spaces/_helpers/common.dart';
import '../code_sheet.dart';

class CodeSelector extends StatelessWidget {
  const CodeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: paddingM('b'),
        child: ValueListenableBuilder(
            valueListenable: Hive.box('${liveSpace()}_${feature.code.t}').listenable(),
            builder: (context, box, widget) {
              return Consumer<InputProvider>(builder: (context, input, child) {
                return AppButton(
                  onPressed: () => showCodeFilesBottomSheet(),
                  dryWidth: true,
                  isDropDown: true,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(child: AppText(text: box.get(input.itemId, defaultValue: {'t': 'Select a file'})['t'])),
                      spw(),
                      AppSvg(dropDownSvg),
                    ],
                  ),
                );
              });
            }),
      ),
    );
  }
}
