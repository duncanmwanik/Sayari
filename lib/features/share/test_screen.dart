import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/helpers.dart';
import '../../__styling/variables.dart';
import '../../_providers/theme.dart';
import 'w/shared_info.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key, required this.id});
  final String id;

  @override
  State<TestScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, dateTime, child) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(getDefaultThemeImage()), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: transparent,
            body: Center(
              child: SharedAction(label: 'This is a test screen for: ${widget.id}.'),
            ),
          ),
        ),
      ),
    );
  }
}
