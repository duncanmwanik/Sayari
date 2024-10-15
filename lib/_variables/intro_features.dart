import 'package:flutter/material.dart';

import '../_models/features.dart';

List<IntroFeature> introFeatures = [
  const IntroFeature(title: 'Notes', description: 'Write anything.', icon: Icons.note),
  const IntroFeature(title: 'Tasks', description: 'Get stuff done.', icon: Icons.check_circle_rounded),
  const IntroFeature(title: 'Calendar', description: 'Manage sessions & plans.', icon: Icons.date_range_rounded),
  const IntroFeature(title: 'Chat', description: 'Keep in touch.', icon: Icons.chat_bubble_rounded),
  const IntroFeature(
    title: 'Plus',
    description: 'Finances • Habits • Links • Bookings • Pomodoro • Blog • Share • Monetization',
    icon: Icons.rocket_launch,
  ),
];
