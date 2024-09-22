import '../_models/features.dart';

Features feature = Features();

class Features {
  String space = 's';
  String calendar = 'c';
  String items = 'i';
  String notes = 'na';
  String tasks = 'ta';
  String finances = 'fa';
  String habits = 'ha';
  String links = 'la';
  String portfolios = 'pa';
  String bookings = 'ba';
  String share = 'sh';
  String chat = 'm';
  String code = 'd';
  String labels = 'b';
  String flags = 'g';
  String subTypes = 'st';
  String pomodoro = 'p';
  String explore = 'e';
  String saved = 'sv';

  bool isSession(String type) => calendar == type;
  bool isNote(String type) => notes == type;
  bool isTask(String type) => tasks == type;
  bool isFinance(String type) => finances == type;
  bool isFinanceT(String type) => finances == type;
  bool isLink(String type) => links == type;
  bool isBooking(String type) => bookings == type;
  bool isShare(String type) => share == type;
  bool isSpace(String type) => space == type;

  FeatureData data(String type) {
    return features[type] ?? FeatureData();
  }

  String cloud(String type) {
    return (features[type] ?? FeatureData()).title.toLowerCase();
  }
}

Map<String, FeatureData> features = {
  feature.space: const FeatureData(title: 'Spaces', message: 'Create Workspace'),
  feature.space: const FeatureData(title: 'Spaces', path: 'book', message: 'Create Workspace'),
  feature.calendar: const FeatureData(title: 'Calendar', message: 'Create Session'),
  feature.items: const FeatureData(title: 'Items', message: 'Create Item'),
  feature.notes: const FeatureData(title: 'Notes', path: 'blog', message: 'Create Note'),
  feature.tasks: const FeatureData(title: 'Tasks', message: 'Create Task'),
  feature.finances: const FeatureData(title: 'Finance', message: 'Create Finance Period'),
  feature.habits: const FeatureData(title: 'Habits', message: 'Create Habit'),
  feature.links: const FeatureData(title: 'Links', path: 'link', message: 'Create Link'),
  feature.portfolios: const FeatureData(title: 'Portfolios', path: '', message: 'Create Portfolio'),
  feature.bookings: const FeatureData(title: 'Bookings', path: 'booking', message: 'Create Booking'),
  feature.explore: const FeatureData(title: 'Explore', message: 'Have Some fun'),
  feature.chat: const FeatureData(title: 'Chat', message: 'Send Message'),
  feature.pomodoro: const FeatureData(title: 'Pomodoro', message: 'Pomodoro'),
  feature.code: const FeatureData(title: 'Code', message: 'Create Code File'),
  feature.saved: const FeatureData(title: 'Saved', message: 'See Saw'),
  feature.share: const FeatureData(title: 'Saved', path: 'shared', message: 'See Saw'),
};

const int sessionsViewDailyNo = 0;
const int sessionsViewWeeklyNo = 1;
const int sessionsViewMonthlyNo = 2;
const int sessionsViewYearlyNo = 3;
const int sessionsViewOmniNo = 0;
