import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_widgets/others/text.dart';

class TableDescription extends StatelessWidget {
  const TableDescription({super.key, required this.tableDescription});

  final String tableDescription;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPaddingMedium(bottom: true),
      child: AppText(
        text: tableDescription,
        faded: true,
      ),
    );
  }
}
