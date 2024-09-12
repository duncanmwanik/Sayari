class Data {
  Data({
    this.all = const [],
    this.pinned = const [],
    this.unpinned = const [],
    this.chosen = const [],
  });

  List all;
  List pinned;
  List unpinned;
  List chosen;

  void setAll(List a, List p, List up, List ch) {
    all = a;
    pinned = p;
    unpinned = up;
    chosen = ch;
  }

  void clear() {
    all.clear();
    pinned.clear();
    unpinned.clear();
    chosen.clear();
  }

  bool isEmpty() {
    return pinned.isEmpty && unpinned.isEmpty && chosen.isEmpty;
  }
}

Data data = Data();
