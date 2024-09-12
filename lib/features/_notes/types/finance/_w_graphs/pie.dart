import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
import 'indicator.dart';

class AppPie extends StatefulWidget {
  const AppPie({super.key, required this.label, required this.data});

  final String label;
  final List data;

  @override
  State<AppPie> createState() => _AppPieState();
}

class _AppPieState extends State<AppPie> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        sph(),
        //
        Align(
          alignment: Alignment.topLeft,
          child: AppButton(
            noStyling: true,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.circle, size: small, faded: true),
                spw(),
                AppText(text: widget.label, faded: true, fontWeight: FontWeight.bold),
              ],
            ),
          ),
        ),
        //
        sph(),
        //
        SizedBox(
          width: 200,
          height: 200,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(show: false),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: List.generate(widget.data.length, (index) {
                Map pieObject = widget.data[index];

                final isTouched = index == touchedIndex;
                final radius = isTouched ? 60.0 : 50.0;

                return PieChartSectionData(color: pieObject['color'], value: pieObject['value'], radius: radius, showTitle: false);
              }),
            ),
          ),
        ),
        //
        mph(),
        //
        for (var pieObject in widget.data) Indicator(color: pieObject['color'], text: pieObject['title']),
        //
      ],
    );
  }
}
