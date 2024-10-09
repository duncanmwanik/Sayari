import '../__styling/helpers.dart';
import '../_helpers/global.dart';
import '../_helpers/helpers.dart';
import '../_variables/constants.dart';
import '../_variables/features.dart';
import '../features/_notes/tasks/_helpers/helper.dart';
import '../features/_spaces/_helpers/common.dart';
import '../features/files/_helpers/helper.dart';

class Item {
  Item({
    this.parent = '',
    this.type = '',
    this.id = '',
    this.sid = '',
    required this.data,
  });

  String parent;
  String type;
  String id;
  String sid;
  Map data;

  void update() {}

  String itemType() =>
      [feature.notes, feature.tasks, feature.links, feature.bookings, feature.habits].firstWhere((key) => data[key] != null);
  String title() => data['t'] != null && data['t'] != '' ? data['t'] : 'Untitled';
  String color() => data['c'] ?? '';
  String emoji() => data['ej'] ?? '';
  String content() => data['n'] ?? '';
  String reminder() => data['r'] ?? '';
  String sessionType() => data['y'] ?? 'Session';
  String labels() => data['l'] ?? '';
  String coverId() => data['w'] ?? '';
  String coverName() => data[coverId()] ?? '';
  String sharedLink() => '$sayariDefaultPath/${features[itemType()]!.path}/${minString(title())}-${liveSpace()}$id';
  String publishedLink() => '$sayariDefaultPath/${features[feature.publish]!.path}/${minString(title())}-${liveSpace()}$id';
  String demoLink() => '/${features[itemType()]!.path}/${minString(title())}-${liveSpace()}$id';
  Map files() => getFiles(data);
  List<String> flags() => splitList(data['g']);
  Map subItems() => getSubItems(data);
  int customHabitDatesCount() => splitList(data['hd']).length;
  int checkedHabitCount() => data.keys.where((key) => key.toString().startsWith('hc')).length;
  int checkedCount() => data.keys.where((key) => key.startsWith('i') && data[key]['v'] == '1').length;
  int taskCount() => data.keys.where((key) => key.startsWith('i')).length;

  bool isNew() => id.isEmpty;
  bool exists() => data.isNotEmpty;
  bool hasTitle() => data['t'] != null && data['t'] != '';
  bool hasColor() => hasColour(data['c']);
  bool hasEmoji() => data['ej'] != null;
  bool hasReminder() => reminder().isNotEmpty;
  bool hasDetails() => reminder().isNotEmpty || labels().isNotEmpty || files().isNotEmpty;
  bool hasOverview() => data['w'] != null && data['w'] != '';
  bool hasFiles() => files().isNotEmpty;
  bool hasFlags() => flags().isNotEmpty;
  bool hasTasks() => taskCount() != 0;
  bool hasFinances() => data[feature.finances] != null;
  bool hasHabits() => data[feature.habits] != null;
  bool hasLinks() => data[feature.links] != null;
  bool hasPortfolios() => data[feature.portfolios] != null;
  bool hasBookings() => data[feature.bookings] != null;
  bool isNote() => data[feature.notes] != null;
  bool isTask() => data[feature.tasks] != null;
  bool isFinance() => data[feature.finances] != null;
  bool isHabit() => data[feature.habits] != null;
  bool isLink() => data[feature.links] != null;
  bool isBooking() => data[feature.bookings] != null;
  bool isPortfolio() => data[feature.portfolios] != null;
  bool isShared() => data[feature.share] != null;
  bool isPublished() => data[feature.publish] == '1';
  bool isPinned() => data['p'] == '1';
  bool isArchived() => data['a'] == '1';
  bool isDeleted() => data['x'] == '1';
  bool isChecked() => data['v'] == '1';
  bool showChecks() => data['v'] == '1';
  bool showEditor() => isNote() || isPortfolio() || isBooking() || isLink();
  bool showFooter() => (isNote() || isBooking() || isFinance()) && !isShare();
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
