import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../__styling/helpers.dart';
import '../../__styling/variables.dart';
import '../../_providers/_providers.dart';
import '../../_providers/theme.dart';
import '../../_services/firebase/database.dart';
import '../../_variables/features.dart';
import '../_spaces/_helpers/common.dart';
import '../_spaces/published/shared.dart';
import 'state/share.dart';
import 'w/shared_info.dart';

class SharedSpace extends StatefulWidget {
  const SharedSpace({super.key, required this.params});
  final String params;

  @override
  State<SharedSpace> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<SharedSpace> {
  String isActive = '';
  String spaceId = '';
  String userId = '';
  String userName = 'User';
  Map sharedData = {};
  Map noteData = {};

  @override
  void initState() {
    super.initState();
    spaceId = publishedSpaceId(widget.params);
    state.share.set(feature.space);
    getSharedData();
  }

  void getSharedData() async {
    await cloudService.getData(db: 'spaces', '$spaceId/info/${feature.share}').then((snapshot) async {
      bool isShared = (snapshot.value != null ? snapshot.value as String : '0') == '1';

      setState(() async {
        if (isShared) {
          isActive = '1';
          // get space info
          await cloudService.getData(db: 'spaces', '$spaceId/info').then((snapshot) async {
            Map data = snapshot.value != null ? snapshot.value as Map : {};

            if (data.isNotEmpty) {
              userId = data['o'];
              sharedData = data;
              state.share.setSharedData(data);
              // get notes
              await cloudService.getData(db: 'spaces', '$spaceId/${feature.notes}').then((snapshot) async {
                Map data = snapshot.value != null ? snapshot.value as Map : {};
                noteData = data;
              });
            }
          });
        } else {
          isActive = '0';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: sharedData['t'] ?? 'Sayari',
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
                      ? sharedData.isNotEmpty
                          ? Align(
                              alignment: Alignment.topCenter,
                              child: PublishBookBody(
                                sharedData: sharedData,
                                userName: userName,
                                data: noteData,
                              ),
                            )
                          : SharedAction()
                      : SharedAction(),
            ),
          ),
        ),
      ),
    );
  }
}
