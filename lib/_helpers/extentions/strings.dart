extension StringExtentions on String {
  String capFirst() {
    if (length > 30) {
      return '${substring(0, 30)}...';
    } else {
      return this;
    }
  }

  String fewWords() => (length > 30 ? '${substring(0, 30)}...' : this);
  String naked() => replaceAll(RegExp('[^A-Za-z0-9]'), '_');
}
