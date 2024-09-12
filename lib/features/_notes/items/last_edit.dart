import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_widgets/others/text.dart';

class LastEdit extends StatelessWidget {
  const LastEdit({super.key, this.timestamp});

  final String? timestamp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPaddingSmall(left: true),
      child: AppText(
        size: small,
        text: timestamp != null ? getEditDateTime(timestamp!) : '',
        faded: true,
      ),
    );
  }
}
