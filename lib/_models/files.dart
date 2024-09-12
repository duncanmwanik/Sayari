class FileStash {
  FileStash({required this.data, required this.ids});
  Map data;
  List<String> ids;

  void addFile(String fileName, dynamic value) => data[fileName] = value;
  void addFileId(String fileId) => ids.add(fileId);

  String fileId() => ids.first;
  String fileName() => data.keys.first;
  dynamic fileValue() => data.values.first;
  bool isValid() => ids.isNotEmpty;
}
