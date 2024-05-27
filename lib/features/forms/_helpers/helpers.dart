import 'dart:convert';

import '../../../_helpers/_common/global.dart';
import '../../../_providers/providers.dart';

void addForm() {
  String linkId = 'qq${getUniqueId()}';
  List linkOrderList = getSplitList(state.input.data['qo']);
  linkOrderList.add(linkId);
  state.input.update(action: 'add', key: 'qo', value: getJoinedList(linkOrderList));
  state.input.update(action: 'add', key: linkId, value: jsonEncode({}));
}
