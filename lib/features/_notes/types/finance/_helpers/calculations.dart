import '../../../../../_models/item.dart';

double getTotalAmount(Item item, String start) {
  double total = 0;

  item.data.forEach((key, value) {
    if (key.toString().startsWith(start)) {
      double amount = double.parse(value['a']);
      total += amount;
    }
  });

  return total;
}

double getAllAmounts(Item item) {
  return getTotalAmount(item, 'in') + getTotalAmount(item, 'ex') + getTotalAmount(item, 'sa');
}
