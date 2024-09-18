import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../_providers/common/misc.dart';
import 'option.dart';

class ChatOptions extends StatelessWidget {
  const ChatOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chat, child) {
      return Wrap(
        spacing: smallWidth(),
        runSpacing: smallWidth(),
        children: [
          //
          ChatOption(type: 'All'),
          ChatOption(type: 'Pinned', iconData: Icons.push_pin_outlined),
          ChatOption(type: 'Starred', iconData: Icons.star_outlined),
          //
        ],
      );
    });
  }
}
