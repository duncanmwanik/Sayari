import '../../../_variables/features.dart';

String getWindowTitle(String type, String itemTitle) {
  return feature.isSpaceT(type)
      ? itemTitle
      : feature.isShareT(type)
          ? 'Shared - $itemTitle'
          : feature.isNoteT(type)
              ? 'Blog - $itemTitle'
              : feature.isBookingT(type)
                  ? 'Booking - $itemTitle'
                  : feature.isLinkT(type)
                      ? 'Links - $itemTitle'
                      : 'Sayari';
}

String sharedId(String? path) => path != null ? path.substring(path.length - 13) : 'sayari';
