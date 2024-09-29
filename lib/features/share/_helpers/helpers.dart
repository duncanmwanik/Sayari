import '../../../_variables/features.dart';

String getWindowTitle(String type, String itemTitle) {
  return feature.isSpace(type)
      ? itemTitle
      : feature.isShare(type)
          ? 'Shared - $itemTitle'
          : feature.isNote(type)
              ? 'Blog - $itemTitle'
              : feature.isBooking(type)
                  ? 'Booking - $itemTitle'
                  : feature.isLink(type)
                      ? 'Links - $itemTitle'
                      : 'Sayari';
}

String sharedId(String? path) {
  try {
    return path != null ? path.substring(path.length - 13) : 'sayari';
  } catch (e) {
    return 'sayari';
  }
}

String sharedSpaceId(String? path) {
  try {
    return path != null ? path.substring(path.length - 30, path.length - 13) : 'sayari';
  } catch (e) {
    return 'sayari';
  }
}
