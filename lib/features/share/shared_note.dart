import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../_helpers/debug.dart';
import '../../_providers/_providers.dart';
import '../../_providers/theme.dart';
import '../../_services/firebase/database.dart';
import '../../_theme/variables.dart';
import '../../_variables/features.dart';
import '../../_widgets/others/background.dart';
import '../_notes/types/blog/blog_body.dart';
import '../_notes/types/bookings/_w_shared/body.dart';
import '../_notes/types/links/_w_shared/links_body.dart';
import '_helpers/helpers.dart';
import 'state/share.dart';
import 'w/shared_info.dart';

class SharedNote extends StatefulWidget {
  const SharedNote({super.key, required this.params, required this.type});
  final String params;
  final String type;

  @override
  State<SharedNote> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<SharedNote> {
  String id = '';
  String isActive = '';
  bool isPublished = false;
  String spaceId = '';
  String userId = '';
  String userName = 'User';
  Map noteData = {};

  @override
  void initState() {
    super.initState();
    id = sharedId(widget.params);
    spaceId = sharedSpaceId(widget.params);
    state.share.set(widget.type);
    show('$spaceId : $id');
    getSharedData();
  }

  void getSharedData() async {
    await cloudService.getData(db: 'spaces', '$spaceId/${feature.notes}/$id/${feature.share}').then((snapshot) async {
      bool isShared = (snapshot.value != null ? snapshot.value as String : '0') == '1';

      setState(() async {
        if (isShared) {
          isActive = '1';
          // is publish active
          if (widget.type.isPublish()) {
            await cloudService.getData(db: 'spaces', '$spaceId/${feature.notes}/$id/${feature.publish}').then((snapshot) async {
              isPublished = (snapshot.value != null ? snapshot.value as String : '0') == '1';
              if (!isPublished) isActive = '0';
            });
          }
          // get note data
          await cloudService.getData(db: 'spaces', '$spaceId/${feature.notes}/$id').then((snapshot) async {
            Map data = snapshot.value != null ? snapshot.value as Map : {};
            setState(() {
              userId = data['u'] ?? 'none';
              noteData = data;
              state.share.setSharedData(data);
            });
          });
          //
        } else {
          isActive = '0';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    show(isActive);

    return Title(
      title: noteData['t'] ?? 'Sayari',
      color: styler.accentColor(),
      child: Consumer2<ThemeProvider, ShareProvider>(
        builder: (context, dateTime, share, child) {
          return AppBackground(
            child: SafeArea(
              child: Scaffold(
                backgroundColor: transparent,
                body: isActive.isEmpty
                    ? Center(child: SpinKitFadingCube(color: styler.accentColor(), size: 50.0))
                    : isActive == '1'
                        ? Align(
                            alignment: Alignment.topCenter,
                            child:
                                // shared or published
                                widget.type.isShare() || (widget.type.isPublish() && isPublished)
                                    ? BlogBody(id: id, userId: userId, userName: userName, data: noteData)
                                    // booking
                                    : widget.type.isBooking()
                                        ? BookingBody(
                                            spaceId: spaceId,
                                            id: id,
                                            userId: userId,
                                            userName: userName,
                                            data: noteData,
                                          )
                                        // links
                                        : widget.type.isLink()
                                            ? LinksBody(
                                                spaceId: spaceId,
                                                id: id,
                                                userId: userId,
                                                userName: userName,
                                                data: noteData,
                                              )
                                            // else
                                            : SharedAction(),
                          )
                        : SharedAction(),
              ),
            ),
          );
        },
      ),
    );
  }
}
