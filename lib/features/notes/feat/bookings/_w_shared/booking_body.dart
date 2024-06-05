import 'package:flutter/material.dart';

import '../../../../../__styling/breakpoints.dart';
import '../../../../../__styling/spacing.dart';
import '../../../../share/_w/shared_info.dart';
import 'booker.dart';
import 'intro.dart';

class BookingBody extends StatelessWidget {
  const BookingBody(
      {super.key,
      required this.tableId,
      required this.itemId,
      required this.userId,
      required this.userName,
      required this.data});

  final String tableId;
  final String itemId;
  final String userId;
  final String userName;
  final Map data;

  @override
  Widget build(BuildContext context) {
    bool isActive = data['ba'] == '1';

    return isActive
        ? SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: isPhone() ? 10 : 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                Wrap(
                  runSpacing: mediumHeight(),
                  children: [
                    //
                    BookingIntro(userId: userId, userName: userName, quills: data['n']),
                    //
                    mpw(),
                    //
                    Booker(tableId: tableId, itemId: itemId, data: data, userName: userName),
                    //
                  ],
                ),
                //
                lph(),
                //
              ],
            ),
          )
        : SharedItemInfo(label: 'The booking session is currently inactive.');
  }
}
