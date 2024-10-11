import '../../../_helpers/global.dart';
import '../../../_variables/features.dart';

List getChosenItems(Map data, String currentTag, String type) {
  List allIds = data.keys.toList();
  allIds.sort((a, b) => int.parse(data[a]['o']).compareTo(int.parse(data[b]['o'])));
  List finalIds = allIds.reversed.toList();

  List chosen = [];
  List pinned = [];

  for (var id in finalIds) {
    Map noteData = data[id];
    List labelList = splitList(noteData['l']);
    bool isPinned = noteData['p'] == '1';
    bool isDeleted = noteData['x'] == '1';
    bool isArchived = noteData['a'] == '1';
    bool isChosenType = feature.isTask(type) ? noteData.containsKey(type) : !noteData.containsKey(feature.tasks);

    if (!isChosenType) continue;

    if (isPinned) pinned.add(id);

    if (currentTag == 'All') {
      if (!isDeleted && !isArchived) {
        chosen.add(id);
      }
    } else if (currentTag == 'Trash') {
      if (isDeleted) {
        chosen.add(id);
      }
    } else if (currentTag == 'Archive') {
      if (isArchived && !isDeleted) {
        chosen.add(id);
      }
    } else {
      if (labelList.contains(currentTag) && !isDeleted && !isArchived) {
        chosen.add(id);
      }
    }
  }

  for (var id in pinned) {
    if (chosen.contains(id)) {
      chosen.remove(id);
      chosen.insert(0, id);
    }
  }

  return chosen;
}
