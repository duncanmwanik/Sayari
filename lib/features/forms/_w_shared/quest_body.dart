import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../share/_w/footer.dart';
import '../../share/_w/shared_info.dart';
import 'intro.dart';
import 'questions.dart';

class FormBody extends StatelessWidget {
  const FormBody({super.key, required this.tableId, required this.itemId, required this.userId, required this.userName, required this.data});

  final String tableId;
  final String itemId;
  final String userId;
  final String userName;
  final Map data;

  @override
  Widget build(BuildContext context) {
    bool isActive = data['qa'] == '1';

    return isActive
        ? ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  lph(),
                  //
                  FormsIntro(userId: userId, userName: userName, data: data),
                  //
                  mph(),
                  //
                  Questions(tableId: tableId, itemId: itemId, data: data),
                  //
                  spph(),
                  //
                  SharedFooter(),
                  //
                  lpph(),
                  //
                ],
              ),
            ),
          )
        : SharedItemInfo(label: 'Oh man! This is the missing link.');
  }
}
