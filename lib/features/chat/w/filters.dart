import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../state/chat.dart';
import 'option.dart';

class ChatFilters extends StatelessWidget {
  const ChatFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chat, child) {
      return Wrap(
        spacing: smallWidth(),
        runSpacing: smallWidth(),
        children: [
          //
          ChatFilter(type: 'All'),
          ChatFilter(type: 'Pinned', iconData: Icons.push_pin_outlined),
          ChatFilter(type: 'Starred', iconData: Icons.star_outlined),
          //
        ],
      );
    });
  }
}
