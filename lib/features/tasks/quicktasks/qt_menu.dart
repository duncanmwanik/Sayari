import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../_notes/_helpers/delete_item.dart';

List<Widget> qtMenu(Item item) {
  return [
    MenuItem(
        label: 'Edit',
        leading: Icons.edit,
        onTap: () {
          state.input.set(Item(
            parent: feature.timeline,
            id: feature.tasks,
            sid: item.sid,
            data: item.data,
          ));
          state.focus.set(item.sid);
        }),
    MenuItem(label: 'Delete', leading: Icons.delete, onTap: () => deleteItemForever(item)),
  ];
}
