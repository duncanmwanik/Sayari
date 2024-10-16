import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../_widgets/others/others/scroll.dart';
import '../../../../share/w/header.dart';
import '../../../../share/w/shared_info.dart';
import 'booker.dart';
import 'intro.dart';

class BookingBody extends StatelessWidget {
  const BookingBody({super.key, required this.spaceId, required this.id, required this.userId, required this.userName, required this.data});

  final String spaceId;
  final String id;
  final String userId;
  final String userName;
  final Map data;

  @override
  Widget build(BuildContext context) {
    bool isActive = data['ba'] == '1';

    return NoScrollBars(
      child: isActive
          ? SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  SharedHeader(userId: userId, data: data),
                  //
                  Padding(
                    padding: padding(),
                    child: Wrap(
                      runSpacing: mediumHeight(),
                      children: [
                        //
                        BookingIntro(
                          userId: userId,
                          userName: userName,
                          title: data['t'],
                          quills: data['n'],
                        ),
                        //
                        mpw(),
                        //
                        Booker(spaceId: spaceId, id: id, data: data, userName: userName),
                        //
                      ],
                    ),
                  ),
                  //
                  lph(),
                  //
                ],
              ),
            )
          : SharedAction(label: 'The booking session is not active.'),
    );
  }
}
