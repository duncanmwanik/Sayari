import 'dart:convert';

import '../../../../../_helpers/_common/global.dart';
import '../../../../../_providers/providers.dart';

void addLink() {
  String linkId = 'wk${getUniqueId()}';
  List linkOrderList = getSplitList(state.input.data['wo']);
  linkOrderList.add(linkId);
  state.input.update(action: 'add', key: 'wo', value: getJoinedList(linkOrderList));
  state.input.update(action: 'add', key: linkId, value: jsonEncode({}));
}
