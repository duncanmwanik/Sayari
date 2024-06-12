import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/input.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../_tables/_helpers/common.dart';
import 'code_file_options.dart';

class CodeFilesList extends StatelessWidget {
  const CodeFilesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPaddingMedium(),
      child: ValueListenableBuilder(
          valueListenable: Hive.box('${liveTable()}_${feature.code.t}').listenable(),
          builder: (context, box, widget) {
            List codeFilesKeys = box.keys.toList();

            return codeFilesKeys.isNotEmpty
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(codeFilesKeys.length, (index) {
                      String codeId = codeFilesKeys[index];
                      Map codeMap = box.get(codeId);

                      return Consumer<InputProvider>(builder: (context, input, child) {
                        return Padding(
                          padding: itemPaddingSmall(bottom: true),
                          child: AppButton(
                            onPressed: () => input.setInputData(typ: feature.code.t, id: codeId, dta: codeMap),
                            smallRightPadding: true,
                            noStyling: input.itemId != codeId,
                            child: Row(
                              children: [
                                AppIcon(Icons.code, size: medium),
                                spw(),
                                Expanded(child: AppText(text: codeMap['t'])),
                                spw(),
                                CodeFileOptions(codeId: codeId, codeMap: codeMap),
                              ],
                            ),
                          ),
                        );
                      });
                    }),
                  )
                : Padding(
                    padding: itemPadding(top: true),
                    child: AppText(text: 'No code files...', textAlign: TextAlign.center, faded: true),
                  );
          }),
    );
  }
}
