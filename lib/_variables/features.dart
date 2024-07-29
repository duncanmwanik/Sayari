import '../_models/features.dart';

Features feature = Features();

class Features {
  final Feature table = Feature(t: 'tables', lt: 't');
  final Feature sessions = Feature(t: 'calendar', lt: 's');
  final Feature tasks = Feature(t: 'tasks', lt: 'ta');
  final Feature notes = Feature(t: 'notes', lt: 'na');
  final Feature finances = Feature(t: 'finances', lt: 'ca');
  final Feature habits = Feature(t: 'habits', lt: 'ha');
  final Feature links = Feature(t: 'links', lt: 'wa');
  final Feature portfolios = Feature(t: 'portfolio', lt: 'pa');
  final Feature forms = Feature(t: 'forms', lt: 'qa');
  final Feature bookings = Feature(t: 'bookings', lt: 'ba');
  final Feature share = Feature(t: 'blog', lt: 'sh');
  final Feature chat = Feature(t: 'chat', lt: 'c');
  final Feature code = Feature(t: 'code', lt: 'd');
  final Feature labels = Feature(t: 'labels', lt: 'b');
  final Feature flags = Feature(t: 'flags', lt: 'g');
  final Feature subTypes = Feature(t: 'subtypes', lt: 'st');
  final Feature pomodoro = Feature(t: 'pomodoro', lt: 'p');
  final Feature explore = Feature(t: 'explore', lt: 'e');
  final Feature hub = Feature(t: 'home', lt: 'h');

  bool isOrderable(String type) => [notes.t].contains(type);
  bool isSession(String type) => sessions.t == type;

  bool isNote(String type) => notes.t == type;
  bool isTask(String type) => tasks.t == type;
  bool isFinance(String type) => finances.t == type;
  bool isLink(String type) => links.t == type;
  bool isBooking(String type) => bookings.t == type;
  bool isShare(String type) => share.t == type;
  bool isForm(String type) => forms.t == type;
  bool isTable(String type) => table.t == type;
  bool isHome(String type) => hub.t == type;
}

Map<String, FeatureData> featureData = {
  feature.table.t: FeatureData(title: 'Tables', createMessage: 'Create Space'),
  feature.sessions.t: FeatureData(title: 'Calendar', createMessage: 'Create Session'),
  feature.notes.t: FeatureData(title: 'Notes', createMessage: 'Create Note'),
  feature.notes.lt: FeatureData(title: 'Notes', createMessage: 'Create Note'),
  feature.tasks.t: FeatureData(title: 'Tasks', createMessage: 'Create Task'),
  feature.tasks.lt: FeatureData(title: 'Tasks', createMessage: 'Create Task'),
  feature.finances.t: FeatureData(title: 'Finance', createMessage: 'Create Finance Period'),
  feature.finances.lt: FeatureData(title: 'Finance', createMessage: 'Create Finance Period'),
  feature.habits.t: FeatureData(title: 'Habits', createMessage: 'Create Habit'),
  feature.habits.lt: FeatureData(title: 'Habits', createMessage: 'Create Habit'),
  feature.links.t: FeatureData(title: 'Links', createMessage: 'Create Link'),
  feature.links.lt: FeatureData(title: 'Links', createMessage: 'Create Link'),
  feature.portfolios.t: FeatureData(title: 'Portfolios', createMessage: 'Create Portfolio'),
  feature.portfolios.lt: FeatureData(title: 'Portfolios', createMessage: 'Create Portfolio'),
  feature.bookings.t: FeatureData(title: 'Bookings', createMessage: 'Create Booking'),
  feature.bookings.lt: FeatureData(title: 'Bookings', createMessage: 'Create Booking'),
  feature.forms.t: FeatureData(title: 'Forms', createMessage: 'Create Form'),
  feature.forms.lt: FeatureData(title: 'Forms', createMessage: 'Create Form'),
  feature.explore.t: FeatureData(title: 'Explore', createMessage: 'Have Some fun'),
  feature.chat.t: FeatureData(title: 'Chat', createMessage: 'Send Message'),
  feature.pomodoro.t: FeatureData(title: 'Pomodoro', createMessage: 'Pomodoro'),
  feature.code.t: FeatureData(title: 'Code', createMessage: 'Create Code File'),
  feature.hub.t: FeatureData(title: 'Home', createMessage: 'Get Comfortable'),
};

const int sessionsViewDailyNo = 0;
const int sessionsViewWeeklyNo = 1;
const int sessionsViewMonthlyNo = 2;
const int sessionsViewYearlyNo = 3;
const int sessionsViewOmniNo = 0;
