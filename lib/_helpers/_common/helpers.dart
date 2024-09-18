import '../../_providers/providers.dart';

Future delay(int seconds) async => await Future.delayed(Duration(seconds: seconds));
bool isShare() => state.share.isShare();

// string helpers
String minString(String? title) => title != null ? title.replaceAll(RegExp('[^A-Za-z0-9]'), '_') : 'item';
String capitalFirst(String word) => word.length > 2 ? '${word[0].toUpperCase()}${word.substring(1)}' : word;
