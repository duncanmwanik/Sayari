import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_providers/common/theme.dart';
import '../../_widgets/buttons/buttons.dart';
import '../../_widgets/buttons/close_button.dart';
import '../../_widgets/others/forms/input.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '../../_widgets/sheets/bottom_sheet.dart';
import '../user/_helpers/set_user_data.dart';
import '_w/reset_password.dart';

Future<void> showEditDetailsBottomSheet(BuildContext context) async {
  final formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController(text: liveUserName());
  final TextEditingController passwordController = TextEditingController();

  await showAppBottomSheet(
    //
    header: Row(
      children: [
        AppCloseButton(isX: false),
        mpw(),
        Flexible(child: AppText(size: normal, text: 'Edit Account Details')),
      ],
    ),
    //
    content: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            mph(),
            //
            Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  DataInput(hintText: 'Name', controller: userNameController),
                  //
                  sph(),
                  //
                  DataInput(
                    hintText: 'Confirm Password',
                    controller: passwordController,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                  ),
                  //
                  mph(),
                  //
                  AppButton(
                    onPressed: () async {
                      hideKeyboard();
                      if (formKey.currentState!.validate()) {
                        // await editUserDetails(userNameController.text.trim(), passwordController.text.trim());
                      }
                    },
                    padding: EdgeInsets.only(left: 25, top: 10, bottom: 10, right: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [AppText(text: 'Update', textAlign: TextAlign.center), spw(), AppIcon(Icons.arrow_forward, tiny: true)],
                    ),
                  ),
                  //
                ],
              ),
            ),
            //
            mph(),
            //
            PasswordResetWidget(),
            //
          ],
        ),
      );
    }),
    //
  );
}
