import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../__styling/helpers.dart';
import '../../__styling/variables.dart';
import '../../_providers/common/misc.dart';
import '../../_providers/common/theme.dart';
import '../../_providers/providers.dart';
import '../../_services/firebase/database.dart';
import '../../_variables/features.dart';
import '../_notes/type/bookings/_w_shared/body.dart';
import '../_notes/type/links/_w_shared/links_body.dart';
import '../_spaces/published/shared.dart';
import '_helpers/helpers.dart';
import '_w/blog_body.dart';
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
          isActive = data[feature.share.lt] ?? '0';
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
    // printThis(isActive);
    // printThis(widget.id);

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
                            feature.isSpaceT(widget.type) ? '$spaceId/${feature.items.t}' : '$spaceId/${feature.items.t}/${widget.id}',
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasError) {
                                return SharedAction();
                              } else if (snapshot.hasData) {
                                Map data = snapshot.data!.value != null ? snapshot.data!.value as Map : {};
                                // printThis(data);

                                return data.isNotEmpty
                                    ? Align(
                                        alignment: Alignment.topCenter,
                                        child: feature.isShareT(widget.type) || feature.isNoteT(widget.type)
                                            ? BlogBody(itemId: widget.id, userId: userId, userName: userName, data: data)
                                            : feature.isBookingT(widget.type)
                                                ? BookingBody(
                                                    spaceId: spaceId, itemId: widget.id, userId: userId, userName: userName, data: data)
                                                : feature.isLinkT(widget.type)
                                                    ? LinksBody(
                                                        spaceId: spaceId, itemId: widget.id, userId: userId, userName: userName, data: data)
                                                    : feature.isSpaceT(widget.type)
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
