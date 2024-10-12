import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/others/others/other.dart';
import '../../../_widgets/others/text.dart';
import '../../calendar/_helpers/date_time/misc.dart';

class LastEdit extends StatelessWidget {
  const LastEdit({super.key, this.timestamp});

  final String? timestamp;

  @override
  Widget build(BuildContext context) {
    return timestamp != null
        ? Padding(
            padding: paddingS('l'),
            child: AppText(
              size: tiny,
              text: 'Edited ${getEditDateTime(timestamp!)}',
              faded: true,
            ),
          )
        : NoWidget();
  }
}
