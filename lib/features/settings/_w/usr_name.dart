import 'package:flutter/material.dart';

import '../../../__styling/variables.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/forms/input.dart';
import '../../../_widgets/others/icons.dart';
import '../../user/_helpers/set_user_data.dart';

class UserName extends StatefulWidget {
  const UserName({super.key});

  @override
  State<UserName> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<UserName> {
  TextEditingController usernameController = TextEditingController(text: liveUserName());

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DataInput(
      hintText: 'Username',
      controller: usernameController,
      enabled: false,
      suffix: AppButton(
        onPressed: () {},
        child: AppIcon(Icons.edit, size: normal),
      ),
    );
  }
}
