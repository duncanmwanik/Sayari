import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_providers/_providers.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../_notes/_helpers/quick_edit.dart';
import '../block_description.dart';
import 'delay.dart';
import 'if.dart';
import 'led_pin.dart';
import 'pin_state.dart';

class CodeBlock extends StatelessWidget {
  const CodeBlock({super.key, required this.type, this.data, this.index = 0});

  final String type;
  final String? data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        if (data == null)
          AppButton(
            onPressed: () {
              List blocks = getSplitList(state.input.data['b']);
              if (type == 'd') blocks.add('$type,10');
              if (type == 'l') blocks.add('$type,h,1');
              if (type == 'p') blocks.add('$type,h,1');
              if (type == 'i') blocks.add('$type,h,1');
              if (type == 'w') blocks.add('$type,h,1');
              state.input.update('b', getJoinedList(blocks));
              editItemExtras(type: feature.code, itemId: state.input.itemId, key: 'b', value: getJoinedList(blocks));
              // print(blocks);
            },
            isRound: true,
            child: AppIcon(Icons.add, size: 16, faded: true),
          ),
        //
        if (data == null) spw(),
        //
        Flexible(
          child: AppButton(
            onPressed: () {
              List blocks = getSplitList(state.input.data['b']);
              if (type == 'd') blocks.add('$type,10');
              if (type == 'l') blocks.add('$type,h,1');
              if (type == 'p') blocks.add('$type,h,1');
              if (type == 'i') blocks.add('$type,h,1');
              if (type == 'w') blocks.add('$type,h,1');
              state.input.update('b', getJoinedList(blocks));
              editItemExtras(type: feature.code, itemId: state.input.itemId, key: 'b', value: getJoinedList(blocks));
              // print(blocks);
            },
            noStyling: true,
            padding: EdgeInsets.zero,
            borderRadius: borderRadiusMediumSmall,
            child: IgnorePointer(
              ignoring: data == null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (type == 'd') DelayBlock(),
                  if (type == 'l') LedColorBlock(),
                  if (type == 'p') PinStateBlock(),
                  if (type == 'i') IfBlock(),
                  if (type == 'w') IfBlock(isWhile: true),
                ],
              ),
            ),
          ),
        ),
        //
        spw(),
        //
        if (data == null) BlockDescription(type),
        //
        if (data != null)
          AppButton(
            onPressed: () {
              List blocks = getSplitList(state.input.data['b']);
              blocks.removeAt(index);
              state.input.update('b', getJoinedList(blocks));
              editItemExtras(type: feature.code, itemId: state.input.itemId, key: 'b', value: getJoinedList(blocks));
            },
            tooltip: 'Delete Block',
            noStyling: true,
            isSquare: true,
            child: AppIcon(Icons.delete, size: 16, extraFaded: true),
          ),
        //
        if (data != null)
          AppButton(
            onPressed: () {},
            tooltip: 'Move Block',
            noStyling: true,
            isSquare: true,
            child: AppIcon(Icons.drag_handle, size: 16, extraFaded: true),
          ),
        //
      ],
    );
  }
}
