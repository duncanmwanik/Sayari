import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../__styling/spacing.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_variables/features.dart';
import '../../_widgets/abcs/dialogs_sheets/dialog_buttons.dart';
import '../../_widgets/others/empty_box.dart';
import '../_spaces/_helpers/common.dart';
import '_w/../flag.dart';

List<Widget> flagsMenu({List<String> alreadySelected = const [], Function(List<String> newFlags)? onDone}) {
  return [FlagsManager(alreadySelected: alreadySelected, onDone: onDone)];
}

class FlagsManager extends StatefulWidget {
  const FlagsManager({super.key, this.alreadySelected = const [], this.onDone});

  final List<String> alreadySelected;
  final Function(List<String> newFlags)? onDone;

  @override
  State<FlagsManager> createState() => _FlagsManagerState();
}

class _FlagsManagerState extends State<FlagsManager> {
  List<String> selectedFlags = [];

  @override
  void initState() {
    setState(() => selectedFlags = widget.alreadySelected);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Flag(isNewFlag: true),
                //
                ValueListenableBuilder(
                  valueListenable: Hive.box('${liveSpace()}_${feature.flags.t}').listenable(),
                  builder: (context, box, widget) {
                    List flags = box.keys.toList();

                    if (box.keys.isNotEmpty) {
                      return Column(
                        children: List.generate(flags.length, (index) {
                          String flag = flags[index];
                          String color = box.get(flag, defaultValue: '0');
                          return Flag(
                            flag: flag,
                            color: color,
                            isSelected: selectedFlags.contains(flag),
                            onPressed: () => setState(() {
                              selectedFlags.contains(flag) ? selectedFlags.remove(flag) : selectedFlags.add(flag);
                            }),
                            onDelete: () => setState(() => selectedFlags.removeAt(index)),
                          );
                        }),
                      );
                    } else {
                      return EmptyBox(label: 'No flags yet', isSpaced: false, size: 50);
                    }
                  },
                ),
                //
                mph(),
                //
              ],
            ),
          ),
        ),
        //
        sph(),
        //
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ActionButton(
              isCancel: true,
            ),
            ActionButton(
              onPressed: () {
                popWhatsOnTop(); // pop menu
                widget.onDone!(selectedFlags);
              },
            ),
          ],
        ),
        //
      ],
    );
  }
}
