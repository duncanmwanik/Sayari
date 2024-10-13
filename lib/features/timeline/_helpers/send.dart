import '../../../_helpers/debug.dart';

Future<void> saveQuickNote() async {
  try {
    // String message = getQuills();
    // Map messageData = {...state.input.item.data};
    // state.input.clear();
    // state.quill.reset();
    // hideKeyboard();

    // if (message.isNotEmpty) {
    //   String messageId = getUniqueId();
    //   messageData.addAll({'n': message, 'u': liveUser(), 't': liveUserName()});
    //   Box box = storage(feature.chat);

    //   String date = getDatePart(DateTime.now());
    //   Map dateChats = box.get(date, defaultValue: {});
    //   dateChats[messageId] = messageData;
    //   box.put(date, dateChats);

    //   handleFilesCloud(liveSpace(), messageData);
    //   syncToCloud(db: 'spaces', space: liveSpace(), parent: feature.chat, action: 'c', id: date, sid: messageId, data: messageData);
    // }
  } catch (e) {
    errorPrint('saveQuickNote', e);
  }
}
