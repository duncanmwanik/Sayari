import '../_helpers/extentions/strings.dart';
import '../_helpers/global.dart';
import '../_helpers/helpers.dart';
import '../_theme/helpers.dart';
import '../_variables/as.dart';
import '../_variables/features.dart';
import '../features/_notes/types/tasks/_helpers/helper.dart';
import '../features/_spaces/_helpers/common.dart';
import '../features/calendar/_helpers/date_time/misc.dart';
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

  Item.empty() : this(data: {});

  String itemType() =>
      [feature.notes, feature.tasks, feature.links, feature.bookings, feature.habits].firstWhere((key) => data[key] != null);
  String title([String? place]) => data['t'] != null && data['t'] != '' ? data['t'] : (place ?? 'Untitled');
  String? color() => data['c'];
  String emoji() => data['ej'] ?? '';
  String content() => data['n'] ?? '';
  String reminder() => data['r'] ?? '';
  String sessionType() => data['y'] ?? 'Session';
  String tags() => data['l'] ?? '';
  String coverId() => data['w'] ?? '';
  String coverName() => data[coverId()] ?? '';
  String sharedLink() => '$sayariDefaultPath/${itemType().path}/${title().bare()}-${liveSpace()}$id';
  String publishedLink() => '$sayariDefaultPath/${feature.publish.path}/${title().bare()}-${liveSpace()}$id';
  String demoLink() => '/${itemType().path}/${title().bare()}-${liveSpace()}$id';
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
  bool hasTags() => tags().isNotEmpty;
  bool hasReminder() => reminder().isNotEmpty;
  bool hasReminderPassed() => DateTime.parse(reminder()).isBefore(now());
  bool hasDetails() => reminder().isNotEmpty || tags().isNotEmpty || files().isNotEmpty;
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
