import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../__styling/variables.dart';
import '../../../_helpers/clipboard.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/others/icons.dart';

class ShareLink extends StatelessWidget {
  const ShareLink({
    super.key,
    required this.title,
    required this.link,
    this.isProfile = false,
    this.isShareIcon = true,
  });

  final String title;
  final String link;
  final bool isProfile;
  final bool isShareIcon;

  @override
  Widget build(BuildContext context) {
    String message = isProfile
        ? 'Hey, check out my links at 👇\n$link\n\n✨ $title + [Sayari.me]'
        : 'Hey, check out $title! 👇\n\n$link\n\n\nGet all my links at https://sayari.me/duncanmwanik.';
    return AppButton(
      menuItems: [
        MenuItem(label: 'Share ${isProfile ? 'Profile' : 'Link'}', smallHeight: true, popTrailing: true, faded: true),
        menuDivider(),
        MenuItem(label: 'Copy Link', leading: Icons.copy, onTap: () => copyText(message)),
        MenuItem(label: 'X', leading: FontAwesomeIcons.xTwitter, onTap: () {}),
        MenuItem(label: 'Whatsapp', leading: FontAwesomeIcons.whatsapp, onTap: () {}),
        MenuItem(label: 'Facebook', leading: FontAwesomeIcons.facebook, onTap: () {}),
        MenuItem(label: 'Messenger', leading: FontAwesomeIcons.facebookMessenger, onTap: () {}),
        MenuItem(label: 'LinkedIn', leading: FontAwesomeIcons.linkedin, onTap: () {}),
        MenuItem(label: 'Snapchat', leading: FontAwesomeIcons.snapchat, onTap: () {}),
        MenuItem(label: 'Telegram', leading: FontAwesomeIcons.telegram, onTap: () {}),
        MenuItem(label: 'Signal', leading: FontAwesomeIcons.signalMessenger, onTap: () {}),
      ],
      tooltip: 'Share',
      noStyling: true,
      isSquare: true,
      child: AppIcon(isShareIcon ? Icons.share : moreIcon, faded: true),
    );
  }
}
