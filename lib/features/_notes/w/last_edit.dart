import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
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
            padding: padS('l'),
            child: AppText(
              size: tiny,
              text: 'Edited ${getEditDateTime(timestamp!)}',
              faded: true,
            ),
          )
        : NoWidget();
  }
}
