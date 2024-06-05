import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../_providers/common/input.dart';
import '../../../../../_widgets/abcs/menu/menu_item.dart';

class TaskOptions extends StatelessWidget {
  const TaskOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool showCheckBoxes = input.data['v'] == '1';
      bool addToTop = input.data['at'] == '1';

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          MenuItem(
            label: showCheckBoxes ? 'Hide Checkboxes' : 'Show Checkboxes',
            iconData: Icons.check_box_outlined,
            onTap: () => input.update(action: 'add', key: 'v', value: showCheckBoxes ? '0' : '1'),
          ),
          //
          MenuItem(
            label: 'Show new items at the ${addToTop ? 'bottom' : 'top'}',
            iconData: Icons.sort,
            onTap: () => input.update(action: 'add', key: 'at', value: addToTop ? '0' : '1'),
          ),
          //
        ],
      );
    });
  }
}
