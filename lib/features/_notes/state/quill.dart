import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../_helpers/debug.dart';

class QuillProvider with ChangeNotifier {
  QuillController controller = QuillController.basic();
  bool isChanged = false;
  bool isEmpty = false;

  Future<void> reset({String? quills}) async {
    controller = QuillController.basic();
    isChanged = false;
    isEmpty = true;

    try {
      if (quills != null) {
        var json = jsonDecode(quills);
        controller.document = Document.fromJson(json);
      }
      listenToChanges();
    } catch (e) {
      errorPrint('quill-controller-set', e);
    }
  }

  void listenToChanges() {
    try {
      controller.document.changes.listen((event) {
        isChanged = true;
        isEmpty = controller.document.isEmpty();
        notifyListeners();
      });
    } catch (e) {
      errorPrint('quill-controller-listening', e);
    }
  }

  void clear() => controller.clear();
}
