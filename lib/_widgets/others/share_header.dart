import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_providers/providers.dart';
import '../abcs/buttons/buttons.dart';
import 'images.dart';
import 'text.dart';

class ShareHeader extends StatelessWidget {
  const ShareHeader({super.key, required this.publishMap});

  final Map publishMap;

  @override
  Widget build(BuildContext context) {
    String author = state.share.publishData['u'] ?? 'Sayari User';

    return Padding(
      padding: itemPadding(top: true, bottom: true),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
          //
          AppButton(
            onPressed: () => popWhatsOnTop(),
            noStyling: true,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppImage(imagePath: 'assets/images/sayari.png', size: 30),
                spw(),
                AppText(text: 'Sayari', size: normal, fontWeight: FontWeight.w700),
              ],
            ),
          ),
          //
          AppButton(
            onPressed: () => popWhatsOnTop(),
            noStyling: true,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(text: author),
                spw(),
                AppImage(imagePath: 'assets/images/user.png', size: 18),
              ],
            ),
          ),

          //
        ],
      ),
    );
  }
}
