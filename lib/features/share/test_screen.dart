import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_providers/theme.dart';
import '../../_widgets/others/icons.dart';

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
            body: SingleChildScrollView(
              child: Wrap(
                spacing: tinyWidth(),
                runSpacing: tinyWidth(),
                children: List.generate(50, (index) {
                  return AppIcon(Icons.circle, size: 6, extraFaded: true);
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
