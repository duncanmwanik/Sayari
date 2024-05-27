import '../../../_providers/providers.dart';

double getTotalAmount(String start) {
  double total = 0;

  state.input.data.forEach((key, value) {
    if (key.toString().startsWith(start)) {
      double amount = double.parse(value['a']);
      total += amount;
    }
  });

  return total;
}

double getAllAmounts() {
  return getTotalAmount('in') + getTotalAmount('ex') + getTotalAmount('sa');
}
