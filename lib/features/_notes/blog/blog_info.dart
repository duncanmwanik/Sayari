import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/text.dart';
import '../../calendar/_helpers/date_time/misc.dart';
import '../../user/dp.dart';
import 'actions.dart';

class BlogInfo extends StatelessWidget {
  const BlogInfo({super.key, required this.id, required this.userId, required this.userName, required this.data});

  final String id;
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
        UserDp(onPressed: () {}, userId: userId, noViewer: true, isTiny: true, size: normal),
        mpw(),
        //
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            AppButton(
              onPressed: () {},
              noStyling: true,
              padding: EdgeInsets.zero,
              hoverColor: transparent,
              child: AppText(text: userName, size: medium, overflow: TextOverflow.ellipsis),
            ),
            //
            AppText(text: editTime, size: small, faded: true, overflow: TextOverflow.ellipsis),
            //
          ],
        )),
        //
        mph(),
        SharedActions(id: id, userId: userId, data: data),
        //
      ],
    );
  }
}
