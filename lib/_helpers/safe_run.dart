import 'debug.dart';

void safeRun(Function() operation, {String where = 'app-run', Function()? onError}) {
  try {
    operation();
  } catch (e) {
    if (onError != null) onError();
    errorPrint(where, e);
  }
}
