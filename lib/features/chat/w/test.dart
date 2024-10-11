import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../_providers/_providers.dart';
import '../../../_widgets/forms/input.dart';

class ChatTestParams extends StatelessWidget {
  const ChatTestParams({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingM(),
      child: Wrap(
        spacing: smallWidth(),
        runSpacing: smallWidth(),
        children: [
          DataInput(
            hintText: 'UserId',
            initialValue: '30G1a5EngyZSliWA3Kvt3jHeThw0',
            onChanged: (value) {
              state.input.update('u', value.trim());
            },
            filled: false,
            contentPadding: EdgeInsets.zero,
          ),
          DataInput(
            hintText: 'UserName',
            initialValue: 'Wanjiru',
            onChanged: (value) {
              state.input.update('t', value.trim());
            },
            filled: false,
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
