import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/global.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_providers/common/input.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '_w/widgets.dart';
import 'block_chooser.dart';
import 'code_blocks.dart';
import 'repeat.dart';

class CodeView extends StatelessWidget {
  const CodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isPhone() ? Alignment.topCenter : Alignment.topLeft,
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
                          BlockSpeparator(),
                          //
                          BlockChooser(blocks: blocks),
                          //
                          sph(),
                          //
                          AppButton(
                            onPressed: () => openEndDrawer(),
                            borderRadius: borderRadiusLarge,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppIcon(Icons.add, size: 16),
                                tpw(),
                                AppText(text: 'Add Block '),
                              ],
                            ),
                          ),
                          //
                          sph(),
                          //
                          BlockSpeparator(),
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
                  : Center(
                      child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: AppText(size: small, text: 'No code file selected...', faded: true),
                    ));
            }),
          ),
          //
          if (isLargePC()) CodeBlocks(),
          //
          // if (isSmallPC()) spw(),
          //
          // if (isSmallPC()) BlockDescription(),
          //
        ],
      ),
    );
  }
}
