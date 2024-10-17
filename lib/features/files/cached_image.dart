// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:file/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart' as cfile;

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.future,
    required this.completeWidget,
    required this.errorWidget,
    required this.loadingWidget,
  });

  final Future<File?>? future;
  final Widget completeWidget;
  final Widget errorWidget;
  final Widget loadingWidget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return errorWidget;
            } else if (snapshot.hasData) {
              cfile.File? file = snapshot.data;

              return file != null ? completeWidget : errorWidget;
            }
          }
          // for loading process
          return loadingWidget;
        });
  }
}
