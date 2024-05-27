import '../__styling/helpers.dart';
import '../features/files/_helpers/helper.dart';

class Item {
  const Item({this.type = '', this.id = '', this.data = const {}});

  final String type;
  final String id;
  final Map data;

  String title() => data['t'] ?? '';
  String bgColor() => data['c'] ?? '';
  String content() => data['n'] ?? '';
  String reminder() => data['r'] ?? '';
  String labels() => data['l'] ?? '';
  List entries() => data['ol'] ?? [];
  String coverId() => data['w'] ?? '';
  String coverName() => data[coverId()] ?? '';
  Map files() => getFiles(data);

  bool exists() => data.isNotEmpty;
  bool hasColor() => hasBgColor(data['c']);
  bool hasOverview() => data['w'] != null && data['w'] != '';
  bool hasHabit() => data['ha'] != null;
  bool isShared() => data['sa'] != null;
  bool isPublished() => data['sp'] == '1';
  bool isPinned() => data['p'] == '1';
  bool isArchived() => data['a'] == '1';
  bool isDeleted() => data['x'] == '1';
  bool showChecks() => data['v'] == '1';
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
