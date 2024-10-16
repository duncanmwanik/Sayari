import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

import '../../../../../_helpers/global.dart';
import '../../../../../_providers/_providers.dart';

void addLink({bool isTitle = false}) {
  String linkId = '${isTitle ? 'lkt' : 'lk'}${getUniqueId()}';
  List linkOrderList = splitList(state.input.item.data['lo']);
  linkOrderList.add(linkId);
  state.input.update('lo', joinList(linkOrderList));
  state.input.update(linkId, jsonEncode({}));
}

Future<void> openLink(String link) async {
  try {
    await launchUrl(Uri.parse(link), webOnlyWindowName: '_blank');
  } catch (e) {
    //
  }
}
