import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/variables.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../icons.dart';
import 'other_widgets.dart';

class CloudSyncIndicator extends StatefulWidget {
  const CloudSyncIndicator({super.key});

  @override
  State<CloudSyncIndicator> createState() => _CloudSyncIndicatorState();
}

class _CloudSyncIndicatorState extends State<CloudSyncIndicator> with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> animation = CurvedAnimation(
    parent: controller,
    curve: Curves.linear,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: globalBox.listenable(),
        builder: (context, box, widget) {
          bool showLoader = box.get('showUpdateLoader', defaultValue: false);

          if (showLoader) {
            controller.repeat();
          } else {
            controller.stop();
          }

          // return showLoader
          //     ? RotationTransition(
          //         turns: animation,
          //         child: AppIcon(Icons.refresh, color: styler.accentColor(), size: 18),
          //       )
          //     : NoWidget();

          return showLoader ? AppIcon(Icons.cloud_done_rounded, color: styler.accentColor(), size: 16) : NoWidget();
        });
  }
}
// RotationTransition(
//                     turns: animation,
//                     child: AppIcon(Icons.cloud_upload_rounded, color: styler.accentColor(), size: 12),
//                   )