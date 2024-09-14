import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_helpers/_common/global.dart';
import '../../../../../_helpers/_common/navigation.dart';
import '../../../../../_providers/providers.dart';
import '../../../../../_widgets/buttons/buttons.dart';
import '../../../../../_widgets/dialogs/dialog_buttons.dart';
import '../../../../../_widgets/menu/confirmation.dart';
import '../../../../../_widgets/menu/menu_item.dart';
import '../../../../../_widgets/others/forms/input.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/toast.dart';
import '../../../../files/_helpers/upload.dart';
import '../../../../files/image.dart';
import '../../../../files/viewer.dart';

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
      titleController.text = widget.linkData['t'] ?? '';
      linkController.text = widget.linkData['l'] ?? '';
      linkImageId = widget.linkData['f'] ?? '';
      isEdit = widget.linkData.isEmpty;
    });
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasImage = linkImageId.isNotEmpty;
    bool isTitle = widget.linkId.startsWith('lkt');

    return AppButton(
      borderRadius: borderRadiusMediumSmall,
      color: styler.appColor(styler.isDark ? 0.5 : 1),
      padding: padding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title icon
              if (isTitle)
                AppButton(
                  noStyling: true,
                  isSquare: true,
                  child: AppIcon(Icons.text_fields, size: normal, faded: true),
                ),
              // image
              if (!isTitle)
                AppButton(
                  onPressed: hasImage
                      ? null
                      : () async {
                          if (!isEdit) setState(() => isEdit = true);
                          await getFilesToUpload(
                              multiple: false,
                              imagesOnly: true,
                              embed: true,
                              onDone: (stash) {
                                state.input.update(action: 'remove', key: linkImageId);
                                setState(() => linkImageId = stash.fileId());
                              });
                        },
                  menuItems: hasImage
                      ? [
                          MenuItem(
                            label: 'Edit Image',
                            leading: Icons.edit,
                            onTap: () async {
                              if (!isEdit) setState(() => isEdit = true);
                              await getFilesToUpload(
                                  multiple: false,
                                  imagesOnly: true,
                                  embed: true,
                                  onDone: (stash) {
                                    state.input.update(action: 'remove', key: linkImageId);
                                    setState(() => linkImageId = stash.fileId());
                                  });
                            },
                          ),
                          if (linkImageId.isNotEmpty)
                            MenuItem(
                              label: 'View Image',
                              leading: Icons.image,
                              onTap: () => showImageViewer(images: {linkImageId: state.input.data[linkImageId] ?? ''}),
                            ),
                          if (linkImageId.isNotEmpty)
                            MenuItem(
                              label: 'Remove Image',
                              leading: Icons.close,
                              onTap: () async {
                                if (!isEdit) setState(() => isEdit = true);
                                state.input.update(action: 'remove', key: linkImageId);
                                setState(() => linkImageId = '');
                              },
                            ),
                        ]
                      : [],
                  padding: EdgeInsets.zero,
                  hoverColor: hasImage ? transparent : null,
                  child: ImageFile(
                    linkImageId,
                    state.input.data[linkImageId] ?? '',
                    images: {linkImageId: state.input.data[linkImageId] ?? ''},
                    showOptions: false,
                    size: 30,
                    hoverColor: transparent,
                  ),
                ),
              //
              spw(),
              //
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title input
                    DataInput(
                      onChanged: (_) {
                        if (!isEdit) setState(() => isEdit = true);
                      },
                      hintText: 'Title',
                      controller: titleController,
                      color: styler.appColor(0.5),
                      textCapitalization: TextCapitalization.sentences,
                      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    ),
                    //
                    if (isEdit) sph(),
                    // link input
                    if (!isTitle && isEdit)
                      DataInput(
                        onChanged: (_) {
                          if (!isEdit) setState(() => isEdit = true);
                        },
                        hintText: 'https://sayari.com/fun ...',
                        controller: linkController,
                        prefix: AppIcon(Icons.link),
                        color: styler.appColor(0.5),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      ),
                    //
                  ],
                ),
              ),
              // edit link
              if (!isEdit) spw(),
              if (!isEdit)
                AppButton(
                  onPressed: () async {
                    if (!isEdit) setState(() => isEdit = true);
                    printThis(linkImageId);
                  },
                  noStyling: true,
                  isSquare: true,
                  child: AppIcon(Icons.edit, size: normal, faded: true),
                ),
              // reorder link; drag
              //
              if (!isEdit) spw(),
              if (!isEdit)
                ReorderableDragStartListener(
                  index: widget.index,
                  child: AppButton(
                    noStyling: true,
                    isSquare: true,
                    child: AppIcon(Icons.drag_indicator, size: extra, extraFaded: true),
                  ),
                ),
              //
            ],
          ),
          //
          if (isEdit) sph(),
          //
          // actions
          if (isEdit)
            Wrap(
              spacing: smallWidth(),
              runSpacing: smallWidth(),
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                // delete link
                AppButton(
                  menuItems: confirmationMenu(
                    title: 'Remove link${titleController.text.isNotEmpty ? ': ${titleController.text} ' : ''}?',
                    yeslabel: 'Remove',
                    onConfirm: () {
                      List linkOrderList = getSplitList(state.input.data['lo']);
                      linkOrderList.remove(widget.linkId);
                      state.input.update(action: 'add', key: 'lo', value: getJoinedList(linkOrderList));
                      state.input.update(action: 'remove', key: widget.linkId);
                      state.input.update(action: 'remove', key: linkImageId);
                      // in case we have edited the link image
                      state.input.update(action: 'remove', key: widget.linkData['f'] ?? '');
                    },
                  ),
                  noStyling: true,
                  isSquare: true,
                  child: AppIcon(Icons.delete_outline_rounded, tiny: true, faded: true),
                ),
                // cancel edit
                ActionButton(
                  isCancel: true,
                  onPressed: () {
                    setState(() {
                      titleController.text = widget.linkData['t'] ?? '';
                      linkController.text = widget.linkData['l'] ?? '';
                      linkImageId = widget.linkData['f'] ?? '';
                      isEdit = false;
                    });
                  },
                ),
                // save edits
                ActionButton(
                  onPressed: () {
                    if (titleController.text.trim().isNotEmpty) {
                      Map linkData = {
                        't': titleController.text.trim(),
                        'l': linkController.text.trim(),
                        'f': linkImageId,
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
