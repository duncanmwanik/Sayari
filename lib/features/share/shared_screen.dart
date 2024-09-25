import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../__styling/helpers.dart';
import '../../__styling/variables.dart';
import '../../_providers/_providers.dart';
import '../../_providers/theme.dart';
import '../../_services/firebase/database.dart';
import '../../_variables/features.dart';
import '../_notes/bookings/_w_shared/body.dart';
import '../_notes/links/_w_shared/links_body.dart';
import '../_spaces/published/shared.dart';
import '_helpers/helpers.dart';
import '_w/shared_info.dart';
import 'blog/blog_body.dart';
import 'state/share.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key, required this.id, required this.type});
  final String id;
  final String type;

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  String id = '';
  String isActive = '';
  String spaceId = '';
  String userId = '';
  String userName = 'Maker Mo';
  Map sharedData = {};

  @override
  void initState() {
    super.initState();
    state.share.setType(widget.type);
    getSharedData();
  }

  void getSharedData() async {
    await cloudService.getData(db: 'shared', widget.id).then((snapshot) async {
      Map data = snapshot.value != null ? snapshot.value as Map : {};
      if (data.isNotEmpty) {
        setState(() {
          isActive = data[feature.share] ?? '0';
          spaceId = data['s'];
          userId = data['u'];
          sharedData = data;
          state.share.setSharedData(data);
        });
      } else {
        setState(() {
          isActive = '0';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: getWindowTitle(widget.type, sharedData['t'] ?? 'Sayari'),
      color: styler.accentColor(),
      child: Consumer2<ThemeProvider, ShareProvider>(
        builder: (context, dateTime, share, child) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(getDefaultThemeImage()), fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Scaffold(
              backgroundColor: transparent,
              body: isActive.isEmpty
                  ? Center(child: SpinKitFadingCube(color: styler.accentColor(), size: 50.0))
                  : isActive == '1'
                      ? FutureBuilder(
                          future: cloudService.getData(
                            db: 'spaces',
                            feature.isSpace(widget.type) ? '$spaceId/${feature.notes}' : '$spaceId/${feature.notes}/${widget.id}',
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasError) {
                                return SharedAction();
                              } else if (snapshot.hasData) {
                                Map data = snapshot.data!.value != null ? snapshot.data!.value as Map : {};

                                return data.isNotEmpty
                                    ? Align(
                                        alignment: Alignment.topCenter,
                                        child: feature.isShare(widget.type) || feature.isNote(widget.type)
                                            ? BlogBody(itemId: widget.id, userId: userId, userName: userName, data: data)
                                            : feature.isBooking(widget.type)
                                                ? BookingBody(
                                                    spaceId: spaceId, itemId: widget.id, userId: userId, userName: userName, data: data)
                                                : feature.isLink(widget.type)
                                                    ? LinksBody(
                                                        spaceId: spaceId, itemId: widget.id, userId: userId, userName: userName, data: data)
                                                    : feature.isSpace(widget.type)
                                                        ? PublishBookBody(
                                                            sharedData: sharedData,
                                                            userName: userName,
                                                            data: data,
                                                          )
                                                        : SharedAction(),
                                      )
                                    : SharedAction();
                              }
                            }
                            return Center(child: SpinKitFadingCube(color: styler.accentColor(), size: 50.0));
                          })
                      : SharedAction(),
            ),
          ),
        ),
      ),
    );
  }
}
