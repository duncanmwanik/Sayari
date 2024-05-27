import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/dialogs_sheets/confirmation_dialog.dart';
import '../../../_widgets/abcs/dialogs_sheets/dialog_buttons.dart';
import '../../../_widgets/abcs/menu/menu_item.dart';
import '../../../_widgets/others/forms/input.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/toast.dart';
import '../../files/_helpers/upload.dart';
import '../../files/image.dart';
import '../../files/image_viewer.dart';

class LinkItem extends StatefulWidget {
  const LinkItem({super.key, required this.index, required this.linkId, required this.linkData});

  final int index;
  final String linkId;
  final Map linkData;

  @override
  State<LinkItem> createState() => _HabitWeekState();
}

class _HabitWeekState extends State<LinkItem> {
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  bool isEdit = false;
  String linkImageId = '';

  @override
  void initState() {
    setState(() {
      titleController.text = widget.linkData['wt'] ?? '';
      linkController.text = widget.linkData['wl'] ?? '';
      linkImageId = widget.linkData['wf'] ?? '';
      isEdit = widget.linkData.isEmpty;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppButton(
      borderRadius: borderRadiusMediumSmall,
      color: styler.appColor(styler.isDark ? 0.5 : 1),
      padding: itemPadding(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              AppButton(
                menuItems: [
                  MenuItem(
                    label: 'Edit Image',
                    iconData: Icons.edit,
                    onTap: () async {
                      if (!isEdit) setState(() => isEdit = true);
                      await getFilesToUpload(allowMultiple: false, imagesOnly: true).then((fileMap) {
                        if (fileMap.isNotEmpty) {
                          state.input.update(action: 'remove', key: linkImageId);
                          setState(() => linkImageId = fileMap['fileId']);
                        }
                      });
                    },
                  ),
                  if (linkImageId.isNotEmpty)
                    MenuItem(
                      label: 'View Image',
                      iconData: Icons.image,
                      onTap: () => showImageViewer(images: {linkImageId: state.input.data[linkImageId] ?? ''}),
                    ),
                  if (linkImageId.isNotEmpty)
                    MenuItem(
                      label: 'Remove Image',
                      iconData: Icons.close,
                      onTap: () async {
                        if (!isEdit) setState(() => isEdit = true);
                        state.input.update(action: 'remove', key: linkImageId);
                        setState(() => linkImageId = '');
                      },
                    ),
                ],
                padding: EdgeInsets.all(3),
                borderRadius: borderRadiusCrazy,
                child: ImageFile(
                  linkImageId,
                  state.input.data[linkImageId] ?? '',
                  {linkImageId: state.input.data[linkImageId] ?? ''},
                  isLinks: true,
                  radius: borderRadiusCrazy,
                ),
              ),
              //
              Flexible(
                child: Wrap(
                  children: [
                    //
                    if (!isEdit)
                      AppButton(
                        onPressed: () async {
                          if (!isEdit) setState(() => isEdit = true);
                        },
                        noStyling: true,
                        isSquare: true,
                        child: AppIcon(Icons.edit, size: 16, faded: true),
                      ),
                    //
                    if (isEdit)
                      AppButton(
                        onPressed: () => showConfirmationDialog(
                          title: 'Remove link${titleController.text.isNotEmpty ? ': ${titleController.text} ' : ''}?',
                          yeslabel: 'Remove',
                          onAccept: () {
                            List linkOrderList = getSplitList(state.input.data['wo']);
                            linkOrderList.remove(widget.linkId);
                            state.input.update(action: 'add', key: 'wo', value: getJoinedList(linkOrderList));
                            state.input.update(action: 'remove', key: widget.linkId);
                            state.input.update(action: 'remove', key: linkImageId);
                            // in case we have edited the link image
                            state.input.update(action: 'remove', key: widget.linkData['wf'] ?? '');
                          },
                        ),
                        noStyling: true,
                        isSquare: true,
                        child: AppIcon(Icons.delete_outline_rounded, faded: true),
                      ),
                    spw(),
                    ReorderableDragStartListener(
                      index: widget.index,
                      child: AppButton(
                        noStyling: true,
                        isSquare: true,
                        child: AppIcon(Icons.drag_indicator, faded: true),
                      ),
                    ),
                    //
                  ],
                ),
              ),
              //
            ],
          ),
          //
          sph(),
          //
          DataInput(
            hintText: 'Title',
            controller: titleController,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (_) {
              if (!isEdit) setState(() => isEdit = true);
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
          //
          sph(),
          //
          DataInput(
            hintText: 'Link eg: https://sayari.com/fun ...',
            controller: linkController,
            onChanged: (_) {
              if (!isEdit) setState(() => isEdit = true);
            },
            prefix: AppIcon(Icons.link),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
          //
          sph(),
          //
          if (isEdit)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //
                ActionButton(
                  isCancel: true,
                  onPressed: () {
                    setState(() {
                      titleController.text = widget.linkData['wt'] ?? '';
                      linkController.text = widget.linkData['wl'] ?? '';
                      linkImageId = widget.linkData['wf'] ?? '';
                      isEdit = false;
                    });
                  },
                ),
                //
                if (isEdit)
                  ActionButton(
                    onPressed: () {
                      if (titleController.text.trim().isNotEmpty) {
                        Map linkData = {
                          'wt': titleController.text.trim(),
                          'wl': linkController.text.trim(),
                          'wf': linkImageId,
                        };
                        state.input.update(action: 'add', key: widget.linkId, value: jsonEncode(linkData));
                        setState(() => isEdit = false);
                        hideKeyboard();
                      } else {
                        showToast(0, 'Title is required.');
                      }
                    },
                    label: isEdit ? 'Save' : 'Add',
                  ),
                //
              ],
            )
          //
        ],
      ),
    );
  }
}
