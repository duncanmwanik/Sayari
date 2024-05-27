import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../_helpers/_common/global.dart';

class QuillProvider with ChangeNotifier {
  //
  QuillController quillcontroller = QuillController.basic();
  bool isChanged = false;

  Future<void> setQuillController({String? quills}) async {
    quillcontroller = QuillController.basic();
    isChanged = false;

    try {
      if (quills != null && quills.isNotEmpty) {
        var json = jsonDecode(quills);
        quillcontroller.document = Document.fromJson(json);
      }

      //
      quillcontroller.document.changes.listen((event) {
        isChanged = true;
        // quillcontroller.moveCursorToPosition(quillcontroller.selection.base.offset);
        notifyListeners();
      });
    } catch (e) {
      errorPrint('quill-json-doc', e);
    }
  }

  //

  bool fullToolbar = false;

  void showFullToolBar(bool show) {
    fullToolbar = show;
    notifyListeners();
  }

  //
}
