import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../_helpers/debug.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/quill/helpers.dart';

class QuillProvider with ChangeNotifier {
  QuillController controller = QuillController.basic();
  bool isChanged = false;
  bool isEmpty = false;

  Future<void> reset({String? quills, String? savePath}) async {
    controller = QuillController.basic();
    isChanged = false;
    isEmpty = true;

    try {
      if (quills != null) {
        var json = jsonDecode(quills);
        controller.document = Document.fromJson(json);
      }
      listenToChanges(savePath);
    } catch (e) {
      logError('quillControllerReset', e);
    }

    isEmpty = controller.document.isEmpty();
  }

  void listenToChanges(String? savePath) {
    try {
      controller.document.changes.listen((event) {
        isChanged = true;
        isEmpty = controller.document.isEmpty();
        if (savePath != null) globalBox.put(savePath, getQuills());
        show(controller.document.toPlainText());
        notifyListeners();
      });
    } catch (e) {
      logError('quillControllerListening', e);
    }
  }

  void clear() => controller.clear();
}
