import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_providers/common/theme.dart';
import '../../_widgets/others/text.dart';
import '../auth/_helpers/user_details_helper.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () async => context.go(await isFirstTimer() ? '/welcome' : '/'), icon: Icon(Icons.arrow_back_rounded)),
        title: AppText(size: normal, text: 'Surprise !!'),
      ),
      body: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 15.h, right: 15, left: 15),
          children: [
            Image.asset('assets/images/oops.png', height: 30.h),
            AppText(size: normal, text: 'Hey! 😅' '\nWe cherish you.', textAlign: TextAlign.center),
            mph(),
            AppText(size: small, text: "Now, let's go back home...", textAlign: TextAlign.center),
          ],
        );
      }),
    );
  }
}
