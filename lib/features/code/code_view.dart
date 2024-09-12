import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../_helpers/_common/global.dart';
import '../../_providers/common/input.dart';
import '../../_providers/providers.dart';
import '../../_variables/features.dart';
import '../../_widgets/others/empty_box.dart';
import '../../_widgets/others/text.dart';
import '../_spaces/_helpers/common.dart';
import '_w/code_selector.dart';
import '_w/widgets.dart';
import 'block_chooser.dart';
import 'code_blocks.dart';
import 'repeat.dart';

class CodeView extends StatelessWidget {
  const CodeView({super.key});

  @override
  Widget build(BuildContext context) {
    state.input.setInputData(
      typ: feature.code.t,
      id: '1718203152818',
      dta: Hive.box('${liveSpace()}_${feature.code.t}').get('1718203152818'),
      notify: false,
    );

    return Align(
      alignment: isPhone() ? Alignment.topCenter : Alignment.topLeft,
      child: Column(
        children: [
          //
          if (!state.views.showPanelOptions || !showPanelOptions()) CodeSelector(),
          //
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Expanded(
                  child: Consumer<InputProvider>(builder: (context, input, child) {
                    List blocks = getSplitList(input.data['b']);

                    return input.itemId.isNotEmpty
                        ? SingleChildScrollView(
                            padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //
                                AppText(text: 'Start', fontWeight: FontWeight.w900),
                                //
                                BlockSeparator(showAdd: false, isLonger: true),
                                BlockSeparator(),
                                //
                                BlockChooser(blocks: blocks),
                                //
                                BlockSeparator(showAdd: false, isLonger: true),
                                //
                                AppText(text: 'End', fontWeight: FontWeight.w900),
                                //
                                mph(),
                                //
                                CodeRepeat(),
                                //
                                lpph(),
                                //
                              ],
                            ),
                          )
                        : EmptyBox(label: 'Select a code file...');
                  }),
                ),
                //
                if (isLargePC()) CodeBlocks(),
                //
              ],
            ),
          ),
        ],
      ),
    );
  }
}
