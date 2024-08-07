import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/variables.dart';
import '../../../_helpers/_common/helpers.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/abcs/menu/menu_item.dart';

class NavOptionToggle extends StatelessWidget {
  const NavOptionToggle({
    super.key,
    required this.type,
    this.isDefault = false,
  });

  final String type;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: settingBox.listenable(keys: ['showNavOption_$type']),
        builder: (context, box, widget) {
          bool show = box.get('showNavOption_$type', defaultValue: '1') == '1';

          return MenuItem(
            onTap: isDefault ? null : () => box.put('showNavOption_$type', show ? '0' : '1'),
            label: capitalFirst(type),
            trailing: show ? Icons.push_pin : Icons.push_pin_outlined,
            trailingColor: isDefault
                ? styler.appColor(3)
                : show
                    ? styler.accent
                    : null,
            trailingSize: 14,
            pop: false,
          );
        });
  }
}
