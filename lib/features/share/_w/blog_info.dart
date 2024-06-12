import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_widgets/others/text.dart';
import '../../files/user_dp.dart';
import 'actions.dart';

class BlogInfo extends StatelessWidget {
  const BlogInfo({super.key, required this.userId, required this.userName, required this.data});

  final String userId;
  final String userName;
  final Map data;

  @override
  Widget build(BuildContext context) {
    String editTime = getEditDateTime(data['z'] ?? '${DateTime.now().millisecondsSinceEpoch}');

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        UserDp(userId: userId, viewOnly: true, isTiny: true, size: 20),
        //
        mpw(),
        //
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            AppText(
                text: userName,
                size: normal,
                faded: true,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis),
            //
            AppText(text: editTime, faded: true, overflow: TextOverflow.ellipsis),
            //
          ],
        )),
        //
        mph(),
        //
        SharedActions(userId: userId, data: data),
        //
      ],
    );
  }
}
