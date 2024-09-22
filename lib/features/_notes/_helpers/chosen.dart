import '../../../_helpers/_common/global.dart';
import '../../../_providers/_providers.dart';
import '../../../_variables/features.dart';

List getChosenItems(Map data, String currentLabel, [String? itemType]) {
  List allKeys = data.keys.toList();
  allKeys.sort((a, b) => int.parse(data[a]['o']).compareTo(int.parse(data[b]['o'])));
  List finalKeys = allKeys.reversed.toList();

  List chosen = [];
  List pinned = [];

  for (var itemId in finalKeys) {
    Map noteData = data[itemId];
    List labelList = getSplitList(noteData['l']);
    bool isPinned = noteData['p'] == '1';
    bool isDeleted = noteData['x'] == '1';
    bool isArchived = noteData['a'] == '1';
    bool isNoteViewType =
        state.views.isItemView(feature.tasks) ? noteData.containsKey(feature.tasks) : !noteData.containsKey(feature.tasks);

    if (!isNoteViewType && state.views.isItems()) continue;

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
