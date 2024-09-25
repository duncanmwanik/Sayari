import '../../../_helpers/_common/global.dart';
import '../../../_services/notifications/create_notification.dart';
import '../../../_variables/features.dart';
import 'reminders.dart';

Future<void> registerReminder({
  required String type,
  required String itemId,
  required Map itemData,
  String? listName,
  String? reminder,
}) async {
  try {
    String title = '';
    String body = '';
    Map<String, String> data = {};
    String? reminderDate = reminder ?? itemData['r'];

    if (reminderDate != null && reminderDate.isNotEmpty) {
      //
      // for sessions
      //
      if (type == feature.calendar) {
        String lead = itemData['l'] != null ? '<br>Led by: <b>${itemData['l']}</b>.' : '';
        String venue = itemData['v'] != null ? '<br>Venue: <b>${itemData['v']}</b>.' : '';
        String description = itemData['a'] != null ? '<br>${itemData['a']}.' : '';
        List remindersList = getSplitList(itemData['r']);

        if (remindersList.isNotEmpty) {
          for (String reminder in remindersList) {
            int reminderInMinutes = reminderTimeInMinutes(reminder);
            DateTime date = DateTime.parse(reminderDateTime(reminderDate, itemData['s'])).subtract(Duration(minutes: reminderInMinutes));

            if (date.isAfter(DateTime.now())) {
              int id = getNotificationId(itemId) + reminderInMinutes;
              title = itemData['t'] ?? 'Session';
              body = 'Starts in $reminderInMinutes minutes. $lead $venue $description';
              data = {'type': type};

              await createReminderNotification(id: id, title: title, body: body, data: data, date: date);
            }
          }
        }
      }
      //
      // all others
      //
      else {
        DateTime date = DateTime.parse(reminderDate);

        if (date.isAfter(DateTime.now())) {
          //
          if (type == feature.notes) {
            title = itemData['t'] ?? 'Note';
            body = itemData['n'] ?? '';
            data = {'type': type};
          }
          //
          if (type == feature.notes) {
            title = itemData['t'] ?? 'List';
            body = 'You may have some items to work on.';
            data = {'type': type};
          }
          //
          if (title.isNotEmpty) {
            await createReminderNotification(id: getNotificationId(itemId), title: title, body: body, data: data, date: date);
          }
          //
        }
        //
      }
      //
    }
    //
  } catch (e) {
    errorPrint('register-$type-notification', e);
  }
}
