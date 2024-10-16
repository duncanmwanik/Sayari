import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_providers/views.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/spacing.dart';
import '../../tags/selector.dart';
import '../layout/layout_button.dart';
import 'new.dart';

class NoteOptions extends StatelessWidget {
  const NoteOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      bool showTagSelector = !views.showPanelOptions || !showPanelOptions();

      return Row(
        children: [
          //
          if (showTagSelector) TagSelector(),
          //
          Expanded(child: spw()),
          //
          if (isNotPhone()) NewOptions(),
          if (isNotPhone()) spw(),
          LayoutButton(),
          //
        ],
      );
    });
  }
}
