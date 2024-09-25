import '../../../_helpers/_common/global.dart';
import '../../../_variables/features.dart';

List getChosenItems(Map data, String currentLabel, String type) {
  List allIds = data.keys.toList();
  allIds.sort((a, b) => int.parse(data[a]['o']).compareTo(int.parse(data[b]['o'])));
  List finalIds = allIds.reversed.toList();

  List chosen = [];
  List pinned = [];

  for (var itemId in finalIds) {
    Map noteData = data[itemId];
    List labelList = getSplitList(noteData['l']);
    bool isPinned = noteData['p'] == '1';
    bool isDeleted = noteData['x'] == '1';
    bool isArchived = noteData['a'] == '1';
    bool isChosenType = feature.isTask(type) ? noteData.containsKey(type) : !noteData.containsKey(feature.tasks);

    if (!isChosenType) continue;

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
