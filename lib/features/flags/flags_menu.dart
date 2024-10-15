import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../__styling/spacing.dart';
import '../../_helpers/navigation.dart';
import '../../_services/hive/store.dart';
import '../../_variables/features.dart';
import '../../_widgets/buttons/action.dart';
import '../../_widgets/others/empty_box.dart';
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
                // new flag
                Flag(),
                // flag list
                ValueListenableBuilder(
                  valueListenable: storage(feature.flags).listenable(),
                  builder: (context, box, widget) {
                    if (box.keys.isNotEmpty) {
                      return Column(
                        children: List.generate(box.keys.length, (index) {
                          String flagId = box.keyAt(index);
                          String flagData = box.get(flagId, defaultValue: '0,Flag');
                          String color = flagData.substring(0, flagData.indexOf(','));
                          String flag = flagData.substring(flagData.indexOf(',') + 1);
                          return Flag(
                            flagId: flagId,
                            flag: flag,
                            color: color,
                            isSelected: selectedFlags.contains(flagId),
                            onPressed: () => setState(() {
                              selectedFlags.contains(flagId) ? selectedFlags.remove(flagId) : selectedFlags.add(flagId);
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
            ActionButton(isCancel: true),
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
