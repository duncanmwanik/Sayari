import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/menu/menu_item.dart';
import '../../../_widgets/others/svg.dart';
import '../../../_widgets/others/text.dart';
import '../../_spaces/_helpers/common.dart';
import '../types/finance/_w/new_type.dart';

class AppTypePicker extends StatelessWidget {
  const AppTypePicker({
    super.key,
    this.type = '',
    this.subType = '',
    required this.initial,
    required this.typeEntries,
    required this.onSelect,
    this.bgColor,
    this.textColor,
    this.borderRadius,
    this.smallVerticalPadding = false,
  });

  final String type;
  final String subType;
  final String initial;
  final Map typeEntries;
  final Function(String chosenType, String chosenValue) onSelect;
  final Color? bgColor;
  final Color? textColor;
  final double? borderRadius;
  final bool smallVerticalPadding;

  @override
  Widget build(BuildContext context) {
    List typeKeys = typeEntries.keys.toList();

    return AppButton(
      tooltip: 'Type',
      menuItems: [
        ValueListenableBuilder(
            valueListenable: Hive.box('${liveSpace()}_${feature.subTypes.t}').listenable(),
            builder: (context, box, wdgt) {
              Map userTypes = box.get('${type}_$subType', defaultValue: {});

              return Container(
                constraints: BoxConstraints(maxHeight: 300),
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //
                      if (type.isNotEmpty) NewType(type: type, subType: subType),
                      if (type.isNotEmpty) tph(),
                      //
                      for (var type in typeKeys) MenuItem(label: type, onTap: () => onSelect(type, typeEntries[type])),
                      //
                      for (var type in userTypes.keys.toList()) MenuItem(label: type, onTap: () => onSelect(type, typeEntries[type])),
                      //
                    ],
                  ),
                ),
              );
            }),
      ],
      color: bgColor,
      borderRadius: borderRadius,
      isDropDown: true,
      smallVerticalPadding: smallVerticalPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Flexible(child: AppText(text: initial, color: textColor)),
          mpw(),
          AppSvg(svgPath: dropDownSvg, color: textColor),
          //
        ],
      ),
    );
  }
}
