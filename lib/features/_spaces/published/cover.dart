import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../__styling/breakpoints.dart';
import '../../../_services/firebase/database.dart';
import '../../files/image.dart';

class PublishedCover extends StatelessWidget {
  const PublishedCover({super.key, required this.sharedData});

  final Map sharedData;

  @override
  Widget build(BuildContext context) {
    String spaceId = sharedData['s'] ?? '';
    String fileId = sharedData['w'] ?? '';

    return FutureBuilder(
        future: cloudService.getData(db: 'spaces', '$spaceId/info/$fileId'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return ImageFile(
                '',
                '',
                height: (isTabAndBelow() ? 15.h : 20.h) / 0.7092,
                width: isTabAndBelow() ? 15.h : 20.h,
                showOptions: false,
              );
            } else if (snapshot.hasData) {
              String fileName = snapshot.data!.value != null ? snapshot.data!.value as String : '';

              return ImageFile(
                fileId,
                fileName,
                images: {fileId: fileName},
                height: (isTabAndBelow() ? 15.h : 20.h) / 0.7092,
                width: isTabAndBelow() ? 15.h : 20.h,
                showOptions: false,
              );
            }
          }
          return ImageFile(
            '',
            '',
            height: (isTabAndBelow() ? 15.h : 20.h) / 0.7092,
            width: isTabAndBelow() ? 15.h : 20.h,
            showOptions: false,
          );
        });
  }
}
