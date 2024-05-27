import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_providers/common/theme.dart';
import '../../_services/firebase/firebase_database.dart';
import '../../_variables/features.dart';
import '../../_widgets/others/others/divider.dart';
import '../bookings/_w_shared/booking_body.dart';
import '../forms/_w_shared/quest_body.dart';
import '../links/_w_shared/links_body.dart';
import '_w/body.dart';
import '_w/header.dart';
import '_w/shared_info.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key, required this.id, required this.type});
  final String id;
  final String type;

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  String isActive = '';
  String tableId = '';
  String userId = '';
  String userName = '';
  String type = '';

  @override
  void initState() {
    super.initState();
    getSharedData();
  }

  void getSharedData() async {
    await cloudService.getData(db: 'shared', widget.id).then((snapshot) async {
      Map data = snapshot.value != null ? snapshot.value as Map : {};
      if (data.isNotEmpty) {
        setState(() {
          isActive = data['a'] ?? '0';
          tableId = data['t'];
          userId = data['i'];
          userName = data['u'];
          type = data['y'];
        });
      } else {
        setState(() {
          isActive = '1';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, dateTime, child) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(getDefaultThemeImage()),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: transparent,
            body: isActive.isEmpty
                ? Center(child: SpinKitFadingCube(color: styler.accentColor(), size: 50.0))
                : isActive == '1'
                    ? FutureBuilder(
                        future: cloudService.getData(db: 'tables', '$tableId/${feature.notes.t}/${widget.id}'),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasError) {
                              return SharedItemInfo();
                            } else if (snapshot.hasData) {
                              Map data = snapshot.data!.value != null ? snapshot.data!.value as Map : {};

                              return data.isNotEmpty
                                  ? Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: itemPaddingSmall(left: true, right: true),
                                        child: Column(
                                          children: [
                                            //
                                            if (feature.isLink(widget.type)) ph(30),
                                            //
                                            if (feature.isLink(widget.type)) SharedHeader(userId: userId),
                                            //
                                            if (feature.isLink(widget.type)) sph(),
                                            //
                                            if (feature.isLink(widget.type)) AppDivider(height: 0, thickness: 0.05),
                                            //
                                            Expanded(
                                              child: widget.type == 'share'
                                                  ? SharedBody(userId: userId, userName: userName, data: data)
                                                  : feature.isBooking(widget.type)
                                                      ? BookingBody(
                                                          tableId: tableId,
                                                          itemId: widget.id,
                                                          userId: userId,
                                                          userName: userName,
                                                          data: data)
                                                      : feature.isLink(widget.type)
                                                          ? LinksBody(
                                                              tableId: tableId,
                                                              itemId: widget.id,
                                                              userId: userId,
                                                              userName: userName,
                                                              data: data)
                                                          : feature.isForm(widget.type)
                                                              ? FormBody(
                                                                  tableId: tableId,
                                                                  itemId: widget.id,
                                                                  userId: userId,
                                                                  userName: userName,
                                                                  data: data)
                                                              : SharedItemInfo(),
                                            ),
                                            //
                                          ],
                                        ),
                                      ),
                                    )
                                  : SharedItemInfo();
                            }
                          }
                          return Center(child: SpinKitFadingCube(color: styler.accentColor(), size: 50.0));
                        })
                    : SharedItemInfo(),
          ),
        ),
      ),
    );
  }
}
