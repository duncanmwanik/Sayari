List<DateTime> getCurrentWeekDates(DateTime date) {
  int dateNo = date.weekday;

  if (dateNo == 1) {
    return [
      date.subtract(const Duration(days: 1)),
      date,
      date.add(const Duration(days: 1)),
      date.add(const Duration(days: 2)),
      date.add(const Duration(days: 3)),
      date.add(const Duration(days: 4)),
      date.add(const Duration(days: 5)),
    ];
  }
  if (dateNo == 2) {
    return [
      date.subtract(const Duration(days: 2)),
      date.subtract(const Duration(days: 1)),
      date,
      date.add(const Duration(days: 1)),
      date.add(const Duration(days: 2)),
      date.add(const Duration(days: 3)),
      date.add(const Duration(days: 4)),
    ];
  }
  if (dateNo == 3) {
    return [
      date.subtract(const Duration(days: 3)),
      date.subtract(const Duration(days: 2)),
      date.subtract(const Duration(days: 1)),
      date,
      date.add(const Duration(days: 1)),
      date.add(const Duration(days: 2)),
      date.add(const Duration(days: 3)),
    ];
  }
  if (dateNo == 4) {
    return [
      date.subtract(const Duration(days: 4)),
      date.subtract(const Duration(days: 3)),
      date.subtract(const Duration(days: 2)),
      date.subtract(const Duration(days: 1)),
      date,
      date.add(const Duration(days: 1)),
      date.add(const Duration(days: 2)),
    ];
  }
  if (dateNo == 5) {
    return [
      date.subtract(const Duration(days: 5)),
      date.subtract(const Duration(days: 4)),
      date.subtract(const Duration(days: 3)),
      date.subtract(const Duration(days: 2)),
      date.subtract(const Duration(days: 1)),
      date,
      date.add(const Duration(days: 1)),
    ];
  }
  if (dateNo == 6) {
    return [
      date.subtract(const Duration(days: 6)),
      date.subtract(const Duration(days: 5)),
      date.subtract(const Duration(days: 4)),
      date.subtract(const Duration(days: 3)),
      date.subtract(const Duration(days: 2)),
      date.subtract(const Duration(days: 1)),
      date,
    ];
  }
  if (dateNo == 7) {
    return [
      date,
      date.add(const Duration(days: 1)),
      date.add(const Duration(days: 2)),
      date.add(const Duration(days: 3)),
      date.add(const Duration(days: 4)),
      date.add(const Duration(days: 5)),
      date.add(const Duration(days: 6)),
    ];
  }

  return [];
}
