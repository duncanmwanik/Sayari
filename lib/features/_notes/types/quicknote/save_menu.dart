import 'package:flutter/material.dart';

import '../../../../_helpers/debug.dart';
import '../../../../_helpers/extentions/strings.dart';
import '../../../../_helpers/global.dart';
import '../../../../_helpers/sync/create_item.dart';
import '../../../../_models/item.dart';
import '../../../../_providers/_providers.dart';
import '../../../../_variables/features.dart';
import '../../../../_widgets/menu/menu_item.dart';
import '../../../../_widgets/others/toast.dart';
import '../../../../_widgets/quill/helpers.dart';
import '../../../chat/_helpers/send.dart';

List<Widget> saveQuickNoteMenu() {
  bool enabled = !state.quill.isEmpty;

  return [
    MenuItem(
      label: 'Save To New Note',
      leading: Icons.note_add,
      faded: !enabled,
      onTap: enabled
          ? () {
              show(getQuillsText().fewWords());
              state.input.set(Item(
                parent: feature.notes,
                type: feature.notes,
                data: {feature.notes: '1', 'o': getUniqueId(), 'n': getQuills(), 't': getQuillsText().fewWords()},
              ));
              createItem();
              showToast(1, 'Added to note.');
              state.input.clear();
              state.quill.clear();
            }
          : null,
    ),
    // MenuItem(
    //   label: 'Save To Existing Note',
    //   leading: Icons.note,
    //   onTap: () {},
    // ),
    MenuItem(
      label: 'Send To Chat',
      leading: Icons.send,
      faded: !enabled,
      onTap: enabled
          ? () {
              sendMessage();
              showToast(1, 'Sent to chat.');
              state.input.clear();
              state.quill.clear();
            }
          : null,
    ),
  ];
}
