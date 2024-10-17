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
  String subTypes = 'subthiss';
  String pomodoro = 'pomodoro';
  String explore = 'explore';
  String saved = 'saved';
}

Map<String, FeatureData> featureData = {
  feature.space: const FeatureData(title: 'Spaces', path: 'spaces'),
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
  feature.chat: const FeatureData(title: 'Chat'),
  feature.pomodoro: const FeatureData(title: 'Pomodoro'),
  feature.saved: const FeatureData(title: 'Saved'),
  feature.share: const FeatureData(title: 'Shared', path: 'shared'),
  feature.publish: const FeatureData(title: 'Published', path: 'blog'),
};

extension FeatureExtentions on String {
  String title() => featureData[this]!.title;
  String message() => featureData[this]!.message;
  String path() => featureData[this]!.path;

  bool isTimeline() => feature.timeline == this;
  bool isNote() => feature.notes == this;
  bool isCalendar() => feature.calendar == this;
  bool isTask() => feature.tasks == this;
  bool isChat() => feature.chat == this;
  bool isFinance() => feature.finances == this;
  bool isLink() => feature.links == this;
  bool isBooking() => feature.bookings == this;
  bool isShare() => feature.share == this;
  bool isPublish() => feature.publish == this;
  bool isSpace() => feature.space == this;
}
