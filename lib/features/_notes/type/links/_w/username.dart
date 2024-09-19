import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_providers/_providers.dart';
import '../../../../../_widgets/buttons/button.dart';
import '../../../../../_widgets/others/forms/input.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/others/dry_intrinsic_size.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../../user/_helpers/set_user_data.dart';

class LinkUserName extends StatefulWidget {
  const LinkUserName({super.key});

  @override
  State<LinkUserName> createState() => _HabitWeekState();
}

class _HabitWeekState extends State<LinkUserName> {
  TextEditingController titleController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isEdit = false;

  @override
  void initState() {
    setState(() {
      titleController.text = state.input.data['ln'] ?? liveUserName();
    });
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        Flexible(
          child: DryIntrinsicWidth(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                AppText(text: 'sayari.app/', faded: true),
                tpw(),
                //
                Flexible(
                  child: AppButton(
                    noStyling: true,
                    showBorder: isEdit,
                    hoverColor: transparent,
                    borderRadius: borderRadiusTinySmall,
                    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: DataInput(
                            hintText: 'name',
                            controller: titleController,
                            focusNode: focusNode,
                            contentPadding: EdgeInsets.zero,
                            fontSize: medium,
                            color: transparent,
                          ),
                        ),
                        if (isEdit) spw(),
                        if (isEdit) AppIcon(Icons.check_circle_rounded, color: Colors.green),
                      ],
                    ),
                  ),
                ),
                //
                spw(),
                AppButton(
                  onPressed: () {
                    if (isEdit) {
                      // check for username
                    } else {
                      setState(() => isEdit = true);
                    }
                  },
                  noStyling: true,
                  isSquare: true,
                  child: AppIcon(isEdit ? Icons.done : Icons.edit_rounded, tiny: !isEdit, faded: true),
                ),
                //
                if (isEdit) spw(),
                if (isEdit)
                  AppButton(
                    onPressed: () {
                      titleController.text = state.input.data['ln'] ?? liveUserName();
                      setState(() => isEdit = false);
                    },
                    noStyling: true,
                    isSquare: true,
                    child: AppIcon(Icons.close_rounded, faded: true),
                  ),
                //
              ],
            ),
          ),
        ),
      ],
    );
  }
}
