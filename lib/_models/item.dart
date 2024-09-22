import '../__styling/helpers.dart';
import '../_helpers/_common/global.dart';
import '../_helpers/_common/helpers.dart';
import '../_variables/constants.dart';
import '../_variables/features.dart';
import '../features/_notes/type/tasks/_helpers/helper.dart';
import '../features/files/_helpers/helper.dart';

class Item {
  const Item({this.type = '', this.id = '', this.data = const {}, this.extra = ''});

  final String type;
  final String id;
  final Map data;
  final String extra;

  String itemType() => [feature.notes, feature.links, feature.bookings].firstWhere((key) => data[key] != null);
  String title() => data['t'] != null && data['t'] != '' ? data['t'] : 'Untitled';
  String color() => data['c'] ?? '';
  String emoji() => data['j'] ?? '';
  String content() => data['n'] ?? '';
  String reminder() => data['r'] ?? '';
  String sessionType() => data['y'] ?? 'Session';
  String labels() => data['l'] ?? '';
  String coverId() => data['w'] ?? '';
  String coverName() => data[coverId()] ?? '';
  String sharedLink() => '$sayariDefaultPath/${features[itemType()]!.path}/${minString(title())}_$id';
  String demoLink() => '/${features[itemType()]!.path}/${minString(title())}_$id';
  Map files() => getFiles(data);
  Map subItems() => getSubItems(data);
  int customHabitDatesCount() => getSplitList(data['hd']).length;
  int checkedHabitCount() => data.keys.where((key) => key.toString().startsWith('hc')).length;
  int checkedCount() => data.keys.where((key) => key.startsWith('i') && data[key]['v'] == '1').length;
  int taskCount() => data.keys.where((key) => key.startsWith('i')).length;

  bool exists() => data.isNotEmpty;
  bool hasTitle() => data['t'] != null && data['t'] != '';
  bool hasColor() => hasColour(data['c']);
  bool hasEmoji() => data['j'] != null;
  bool hasDetails() => reminder().isNotEmpty || labels().isNotEmpty || files().isNotEmpty;
  bool hasOverview() => data['w'] != null && data['w'] != '';
  bool hasFiles() => files().isNotEmpty;
  bool isTask() => data[feature.tasks] != null;
  bool hasFinances() => data[feature.finances] != null;
  bool hasHabits() => data[feature.habits] != null;
  bool hasLinks() => data[feature.links] != null;
  bool hasPortfolios() => data[feature.portfolios] != null;
  bool hasBookings() => data[feature.bookings] != null;
  bool isNote() => data[feature.notes] != null;
  bool isShared() => data[feature.share] == '1';
  bool isPublished() => data['sp'] == '1';
  bool isPinned() => data['p'] == '1';
  bool isArchived() => data['a'] == '1';
  bool isDeleted() => data['x'] == '1';
  bool showChecks() => data['v'] == '1';
  bool showEditorOverview() => isNote() || hasPortfolios();
  bool showNewEntriesFirst() => data['at'] == '1';

  //
  // for finance only
  //
  double totalIncome() {
    double total = 0;
    data.forEach((key, value) {
      if (key.toString().startsWith('in')) {
        double amount = double.parse(value['a']);
        total += amount;
      }
    });

    return total;
  }

  double totalExpense() {
    double total = 0;
    data.forEach((key, value) {
      if (key.toString().startsWith('ex')) {
        double amount = double.parse(value['a']);
        total += amount;
      }
    });

    return total;
  }

  double totalSavings() {
    double total = 0;
    data.forEach((key, value) {
      if (key.toString().startsWith('sa')) {
        double amount = double.parse(value['a']);
        total += amount;
      }
    });

    return total;
  }
}
