import 'package:flutter/material.dart';

import '../../../../__styling/helpers.dart';
import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/images.dart';
import '../../../../_widgets/others/loader.dart';
import '../../../../_widgets/others/others/other.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/checks_space.dart';
import '../../_helpers/common.dart';
import '../../_helpers/select_space.dart';
import 'space_options.dart';

class SpaceTile extends StatefulWidget {
  const SpaceTile({super.key, required this.spaceId, this.spaceGroupName = ''});

  final String spaceId;
  final String spaceGroupName;

  @override
  State<SpaceTile> createState() => _SpaceTileState();
}

class _SpaceTileState extends State<SpaceTile> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.spaceId == liveSpace();

    return FutureBuilder(
        future: getSpaceNameFuture(widget.spaceId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return NoWidget();
            } else if (snapshot.hasData) {
              final spaceName = snapshot.data as String;

              return AppButton(
                onPressed: isLoading
                    ? () {}
                    : () async {
                        setState(() => isLoading = true);
                        await selectNewSpace(widget.spaceId);
                        setState(() => isLoading = false);
                      },
                color: styler.appColor(1),
                padding: EdgeInsets.only(left: 10, right: 4),
                height: 40,
                child: Row(
                  children: [
                    //
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //
                          AppImage('sayari.png', size: 16),
                          //
                          spw(),
                          // space name
                          Expanded(
                            child: AppText(
                              text: spaceName,
                              textAlign: TextAlign.start,
                              weight: FontWeight.bold,
                              faded: true,
                            ),
                          ),
                          //
                          spw(),
                          // indicator, if space is selected
                          if (isSelected) AppIcon(Icons.done_rounded, size: 18, faded: true),
                          if (isSelected) tpw(),
                          //
                        ],
                      ),
                    ),
                    //
                    isLoading
                        ? Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: AppLoader(color: isImage() ? white : styler.accentColor()),
                          )
                        : SpaceOptions(
                            spaceId: widget.spaceId,
                            spaceName: spaceName,
                            spaceGroupName: widget.spaceGroupName,
                          ),
                    //
                    //
                  ],
                ),
              );
            }
          }
          return NoWidget();
        });
  }
}
