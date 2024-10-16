import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../_models/features.dart';

List<IntroFeature> introFeatures = [
  const IntroFeature(title: 'Notes', description: 'Write anything.', icon: FontAwesomeIcons.solidNoteSticky),
  const IntroFeature(title: 'Tasks', description: 'Get stuff done.', icon: FontAwesomeIcons.solidCircleCheck),
  const IntroFeature(title: 'Calendar', description: 'Manage sessions & plans.', icon: FontAwesomeIcons.solidCalendar),
  const IntroFeature(title: 'Chat', description: 'Keep in touch.', icon: FontAwesomeIcons.solidComments),
  const IntroFeature(
    title: '+ more',
    description: 'Finances • Habits • Links • Bookings • Pomodoro • Blog • Share • Monetization',
    icon: FontAwesomeIcons.rocket,
  ),
];
