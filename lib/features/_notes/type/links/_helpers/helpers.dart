import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

import '../../../../../_helpers/_common/global.dart';
import '../../../../../_providers/providers.dart';

void addLink({bool isTitle = false}) {
  String linkId = '${isTitle ? 'lkt' : 'lk'}${getUniqueId()}';
  List linkOrderList = getSplitList(state.input.data['lo']);
  linkOrderList.add(linkId);
  state.input.update(action: 'add', key: 'lo', value: getJoinedList(linkOrderList));
  state.input.update(action: 'add', key: linkId, value: jsonEncode({}));
}

Future<void> openLink(String link) async {
  try {
    await launchUrl(Uri.parse(link), webOnlyWindowName: '_blank');
  } catch (e) {
    //
  }
}
