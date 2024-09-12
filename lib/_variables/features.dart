import '../_models/features.dart';

Features feature = Features();

class Features {
  final Feature space = const Feature(t: 'spaces', lt: 's');
  final Feature calendar = const Feature(t: 'calendar', lt: 'c');
  final Feature items = const Feature(t: 'items', lt: 'i');
  final Feature notes = const Feature(t: 'note', lt: 'na');
  final Feature tasks = const Feature(t: 'task', lt: 'ta');
  final Feature finances = const Feature(t: 'finance', lt: 'ca');
  final Feature habits = const Feature(t: 'habit', lt: 'ha');
  final Feature links = const Feature(t: 'link', lt: 'la');
  final Feature portfolios = const Feature(t: 'portfolio', lt: 'pa');
  final Feature bookings = const Feature(t: 'booking', lt: 'ba');
  final Feature share = const Feature(t: 'share', lt: 'sh');
  final Feature chat = const Feature(t: 'chat', lt: 'm');
  final Feature code = const Feature(t: 'code', lt: 'd');
  final Feature labels = const Feature(t: 'labels', lt: 'b');
  final Feature flags = const Feature(t: 'flags', lt: 'g');
  final Feature subTypes = const Feature(t: 'subtypes', lt: 'st');
  final Feature pomodoro = const Feature(t: 'pomodoro', lt: 'p');
  final Feature explore = const Feature(t: 'explore', lt: 'e');
  final Feature saved = const Feature(t: 'saved', lt: 'sv');

  bool isOrderable(String type) => [notes.t].contains(type);
  bool isSession(String type) => calendar.t == type;
  bool isNote(String type) => notes.t == type;
  bool isNoteT(String type) => notes.lt == type;
  bool isTask(String type) => tasks.t == type;
  bool isTaskT(String type) => tasks.lt == type;
  bool isFinance(String type) => finances.t == type;
  bool isFinanceT(String type) => finances.lt == type;
  bool isLink(String type) => links.t == type;
  bool isLinkT(String type) => links.lt == type;
  bool isBooking(String type) => bookings.t == type;
  bool isBookingT(String type) => bookings.lt == type;
  bool isShare(String type) => share.t == type;
  bool isShareT(String type) => share.lt == type;
  bool isSpace(String type) => space.t == type;
  bool isSpaceT(String type) => space.lt == type;
}

Map<String, FeatureData> features = {
  feature.space.t: const FeatureData(title: 'Spaces', message: 'Create Workspace'),
  feature.space.lt: const FeatureData(title: 'Spaces', path: 'book', message: 'Create Workspace'),
  feature.calendar.t: const FeatureData(title: 'Calendar', message: 'Create Session'),
  feature.items.t: const FeatureData(title: 'Items', message: 'Create Item'),
  feature.notes.lt: const FeatureData(title: 'Notes', path: 'blog', message: 'Create Note'),
  feature.tasks.lt: const FeatureData(title: 'Tasks', message: 'Create Task'),
  feature.finances.lt: const FeatureData(title: 'Finance', message: 'Create Finance Period'),
  feature.habits.lt: const FeatureData(title: 'Habits', message: 'Create Habit'),
  feature.links.lt: const FeatureData(title: 'Links', path: 'link', message: 'Create Link'),
  feature.portfolios.lt: const FeatureData(title: 'Portfolios', path: '', message: 'Create Portfolio'),
  feature.bookings.lt: const FeatureData(title: 'Bookings', path: 'booking', message: 'Create Booking'),
  feature.explore.t: const FeatureData(title: 'Explore', message: 'Have Some fun'),
  feature.chat.t: const FeatureData(title: 'Chat', message: 'Send Message'),
  feature.pomodoro.t: const FeatureData(title: 'Pomodoro', message: 'Pomodoro'),
  feature.code.t: const FeatureData(title: 'Code', message: 'Create Code File'),
  feature.saved.t: const FeatureData(title: 'Saved', message: 'See Saw'),
  feature.share.lt: const FeatureData(title: 'Saved', path: 'shared', message: 'See Saw'),
};

const int sessionsViewDailyNo = 0;
const int sessionsViewWeeklyNo = 1;
const int sessionsViewMonthlyNo = 2;
const int sessionsViewYearlyNo = 3;
const int sessionsViewOmniNo = 0;
