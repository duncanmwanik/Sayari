import 'package:hive/hive.dart';

import '../../_providers/providers.dart';
import '../../features/_tables/_helpers/common.dart';
import '../_common/global.dart';

List getChosenItems(String type, String currentLabel) {
  Box box = Hive.box('${liveTable()}_$type');
  List allKeys = box.keys.where((key) => key != 'ol').toList().reversed.toList();

  List chosen = [];
  List pinned = [];

  for (var itemId in allKeys) {
    Map noteData = box.get(itemId);
    List labelList = getSplitList(noteData['l']);
    bool isPinned = noteData['p'] == '1';
    bool isDeleted = noteData['x'] == '1';
    bool isArchived = noteData['a'] == '1';
    bool isNoteViewType = noteData.containsKey(state.views.noteView);

    if (!isNoteViewType && state.views.isNotes()) continue;

    if (isPinned) pinned.add(itemId);

    if (currentLabel == 'All') {
      if (!isDeleted && !isArchived) {
        chosen.add(itemId);
      }
    } else if (currentLabel == 'Trash') {
      if (isDeleted) {
        chosen.add(itemId);
      }
    } else if (currentLabel == 'Archive') {
      if (isArchived && !isDeleted) {
        chosen.add(itemId);
      }
    } else {
      if (labelList.contains(currentLabel) && !isDeleted && !isArchived) {
        chosen.add(itemId);
      }
    }
  }

  for (var itemId in pinned) {
    if (chosen.contains(itemId)) {
      chosen.remove(itemId);
      chosen.insert(0, itemId);
    }
  }

  return chosen;
}


// Map sorted = Map.fromEntries(all.entries.toList()..sort((e1, e2) => (e1.value['z'] ?? '0').compareTo(e2.value['z'] ?? '0')));
 // Map sorted = Map.fromEntries(all.entries.toList()
  //   ..sort(
  //     (e1, e2) => int.parse(e1.value['o'] ?? '0').compareTo(int.parse(e2.value['o'] ?? '0')),
  //   ));