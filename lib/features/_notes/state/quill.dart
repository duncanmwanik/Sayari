import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../_helpers/_common/global.dart';

class QuillProvider with ChangeNotifier {
  QuillController controller = QuillController.basic();
  bool isChanged = false;

  bool isEmpty() => controller.document.isEmpty();

  Future<void> reset({String? quills}) async {
    controller = QuillController.basic();
    isChanged = false;

    try {
      if (quills != null && quills.isNotEmpty) {
        var json = jsonDecode(quills);
        controller.document = Document.fromJson(json);
      }

      //
      controller.document.changes.listen((event) {
        isChanged = true;
        // controller.moveCursorToPosition(controller.selection.base.offset);
        notifyListeners();
      });
    } catch (e) {
      errorPrint('quill-controller-set-json-doc', e);
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
