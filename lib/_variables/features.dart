import '../_models/features.dart';

Features feature = Features();

class Features {
  String space = 'space';
  String calendar = 'calendar';
  String notes = 'notes';
  String tasks = 'tasks';
  String finances = 'finances';
  String habits = 'habits';
  String links = 'links';
  String portfolios = 'portfolios';
  String bookings = 'bookings';
  String share = 'shared';
  String chat = 'chat';
  String labels = 'labels';
  String flags = 'flags';
  String subTypes = 'subtypes';
  String pomodoro = 'pomodoro';
  String explore = 'explore';
  String saved = 'saved';

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
}

Map<String, FeatureData> features = {
  feature.space: const FeatureData(title: 'Spaces', path: 'book', message: 'Create Workspace'),
  feature.calendar: const FeatureData(title: 'Calendar', message: 'Create Session'),
  feature.notes: const FeatureData(title: 'Notes', path: 'blog', message: 'Create Note'),
  feature.tasks: const FeatureData(title: 'Tasks', message: 'Create Task'),
  feature.finances: const FeatureData(title: 'Finance', message: 'Create Finance Period'),
  feature.habits: const FeatureData(title: 'Habits', message: 'Create Habit'),
  feature.links: const FeatureData(title: 'Links', path: 'links', message: 'Create Link'),
  feature.portfolios: const FeatureData(title: 'Portfolios', path: '', message: 'Create Portfolio'),
  feature.bookings: const FeatureData(title: 'Bookings', path: 'bookings', message: 'Create Booking'),
  feature.explore: const FeatureData(title: 'Explore', message: 'Have Some fun'),
  feature.chat: const FeatureData(title: 'Chat', message: 'Send Message'),
  feature.pomodoro: const FeatureData(title: 'Pomodoro', message: 'Pomodoro'),
  feature.saved: const FeatureData(title: 'Saved', message: 'See Saw'),
  feature.share: const FeatureData(title: 'Saved', path: 'shared', message: 'See Saw'),
};

const int sessionsViewDailyNo = 0;
const int sessionsViewWeeklyNo = 1;
const int sessionsViewMonthlyNo = 2;
const int sessionsViewYearlyNo = 3;
const int sessionsViewOmniNo = 0;
