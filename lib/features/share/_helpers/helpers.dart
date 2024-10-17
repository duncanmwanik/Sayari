import '../../../_helpers/extentions/strings.dart';
import '../../../_variables/features.dart';

String getWindowTitle(String type, String itemTitle) {
  return type.isSpace()
      ? itemTitle
      : type.isNote()
          ? 'Blog - $itemTitle'
          : '${type.cap()} - $itemTitle';
}

String sharedId(String path) {
  try {
    return path.substring(path.length - 13);
  } catch (e) {
    return 'sayari';
  }
}

String sharedSpaceId(String path) {
  try {
    return path.substring(path.length - 39, path.length - 13);
  } catch (e) {
    return 'sayari';
  }
}
