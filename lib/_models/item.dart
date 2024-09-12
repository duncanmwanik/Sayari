import '../__styling/helpers.dart';
import '../_variables/features.dart';
import '../features/files/_helpers/helper.dart';

class Item {
  const Item({this.type = '', this.id = '', this.data = const {}});

  final String type;
  final String id;
  final Map data;

  String title() => data['t'] != null && data['t'] != '' ? data['t'] : 'Untitled';
  String color() => data['c'] ?? '';
  String content() => data['n'] ?? '';
  String reminder() => data['r'] ?? '';
  String labels() => data['l'] ?? '';
  String coverId() => data['w'] ?? '';
  String coverName() => data[coverId()] ?? '';
  Map files() => getFiles(data);

  bool exists() => data.isNotEmpty;
  bool hasTitle() => data['t'] != null && data['t'] != '';
  bool hasColor() => hasItemColor(data['c']);
  bool hasDetails() => reminder().isNotEmpty || labels().isNotEmpty || files().isNotEmpty;
  bool hasOverview() => data['w'] != null && data['w'] != '';
  bool hasTasks() => data[feature.tasks.lt] != null;
  bool hasFinances() => data[feature.finances.lt] != null;
  bool hasHabits() => data[feature.habits.lt] != null;
  bool hasLinks() => data[feature.links.lt] != null;
  bool hasPortfolios() => data[feature.portfolios.lt] != null;
  bool hasBookings() => data[feature.bookings.lt] != null;
  bool isNote() => data[feature.notes.lt] != null;
  bool isShared() => data[feature.share.lt] == '1';
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
