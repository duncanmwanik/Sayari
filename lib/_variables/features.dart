import '../_models/features.dart';

Features feature = Features();

class Features {
  String space = 'space';
  String timeline = 'timeline';
  String calendar = 'calendar';
  String notes = 'notes';
  String tasks = 'tasks';
  String finances = 'finances';
  String habits = 'habits';
  String links = 'links';
  String portfolios = 'portfolios';
  String bookings = 'bookings';
  String share = 'shared';
  String publish = 'published';
  String chat = 'chat';
  String tags = 'tags';
  String flags = 'flags';
  String subTypes = 'subtypes';
  String pomodoro = 'pomodoro';
  String explore = 'explore';
  String saved = 'saved';

  bool isTimeline(String type) => timeline == type;
  bool isCalendar(String type) => calendar == type;
  bool isNote(String type) => notes == type;
  bool isTask(String type) => tasks == type;
  bool isChat(String type) => chat == type;
  bool isFinance(String type) => finances == type;
  bool isLink(String type) => links == type;
  bool isBooking(String type) => bookings == type;
  bool isShare(String type) => share == type;
  bool isPublish(String type) => publish == type;
  bool isSpace(String type) => space == type;

  FeatureData data(String type) => features[type] ?? FeatureData();
}

Map<String, FeatureData> features = {
  feature.space: const FeatureData(title: 'Spaces', path: 'book'),
  feature.timeline: const FeatureData(title: 'Timeline'),
  feature.calendar: const FeatureData(title: 'Calendar', message: 'New Session'),
  feature.notes: const FeatureData(title: 'Notes', path: 'shared', message: 'New Note'),
  feature.tasks: const FeatureData(title: 'Tasks', message: 'New Task'),
  feature.finances: const FeatureData(title: 'Finance'),
  feature.habits: const FeatureData(title: 'Habits'),
  feature.links: const FeatureData(title: 'Links', path: 'links'),
  feature.portfolios: const FeatureData(title: 'Portfolios', path: 'portfolio'),
  feature.bookings: const FeatureData(title: 'Bookings', path: 'booking'),
  feature.explore: const FeatureData(title: 'Explore'),
  feature.chat: const FeatureData(title: 'Chat', message: 'Send Message'),
  feature.pomodoro: const FeatureData(title: 'Pomodoro', message: 'Pomodoro'),
  feature.saved: const FeatureData(title: 'Saved'),
  feature.share: const FeatureData(title: 'Shared', path: 'shared'),
  feature.publish: const FeatureData(title: 'Published', path: 'blog'),
};

const int sessionsViewDailyNo = 0;
const int sessionsViewWeeklyNo = 1;
const int sessionsViewMonthlyNo = 2;
const int sessionsViewYearlyNo = 3;
