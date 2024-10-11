import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../state/quill.dart';
import 'embed_divider.dart';
import 'embed_image.dart';

Widget getQuillToolbar({bool isMin = false}) {
  var controller = state.quill.controller;
  double iconSize = 12;
  //
  QuillIconTheme? iconTheme = QuillIconTheme(
    iconButtonSelectedData: IconButtonData(
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(
        foregroundColor: white,
        backgroundColor: styler.accentColor(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusTiny)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.all(5),
        iconSize: 12,
      ),
      constraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
    ),
    iconButtonUnselectedData: IconButtonData(
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(
        foregroundColor: styler.textColor(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusTiny)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.all(5),
        iconSize: 12,
      ),
      constraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
    ),
  );
  //
  QuillToolbarCustomButton sizeButton(String label, Attribute attribute) => QuillToolbarCustomButton(
        controller: controller,
        options: QuillToolbarCustomButtonOptions(
          icon: AppText(text: label, weight: FontWeight.bold),
          iconTheme: iconTheme,
          onPressed: () => controller.formatSelection(attribute),
        ),
      );
  //
  QuillToolbarToggleStyleButtonOptions options = QuillToolbarToggleStyleButtonOptions(iconTheme: iconTheme, iconSize: iconSize);
  //
  //

  return ValueListenableBuilder(
      valueListenable: globalBox.listenable(keys: ['${state.views.isChat() ? 'chat' : 'note'}ExpandToolbar']),
      builder: (context, box, child) {
        bool full = box.get('${state.views.isChat() ? 'chat' : 'note'}ExpandToolbar', defaultValue: false);

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            if (full)
              Consumer<QuillProvider>(
                builder: (context, quill, child) => Visibility(
                  visible: quill.isChanged,
                  child: Wrap(
                    children: [
                      // undo
                      QuillToolbarHistoryButton(
                        controller: controller,
                        isUndo: true,
                        options: QuillToolbarHistoryButtonOptions(iconTheme: iconTheme, iconSize: iconSize, tooltip: ''),
                      ),
                      mspw(),
                      // redo
                      QuillToolbarHistoryButton(
                        controller: controller,
                        isUndo: false,
                        options: QuillToolbarHistoryButtonOptions(iconTheme: iconTheme, iconSize: iconSize, tooltip: ''),
                      ),
                      mspw(),
                    ],
                  ),
                ),
              ),
            //
            Expanded(
              child: Wrap(
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: tinyHeight(),
                children: [
                  // bold
                  QuillToolbarToggleStyleButton(controller: controller, attribute: Attribute.bold, options: options),
                  mspw(),
                  // italic
                  if (full) QuillToolbarToggleStyleButton(controller: controller, attribute: Attribute.italic, options: options),
                  if (full) mspw(),
                  // underline
                  if (full) QuillToolbarToggleStyleButton(controller: controller, attribute: Attribute.underline, options: options),
                  if (full) mspw(),
                  // clear formatting
                  if (full) QuillToolbarClearFormatButton(controller: controller, options: options),
                  if (full) mspw(),
                  // list numbered
                  QuillToolbarToggleCheckListButton(
                    controller: controller,
                    options: QuillToolbarToggleCheckListButtonOptions(iconTheme: iconTheme, iconSize: iconSize),
                  ),
                  mspw(),
                  // list bullets
                  if (full) QuillToolbarToggleStyleButton(controller: controller, attribute: Attribute.ul, options: options),
                  if (full) mspw(),
                  // check list
                  QuillToolbarToggleStyleButton(controller: controller, attribute: Attribute.ol, options: options),
                  mspw(),
                  // link
                  if (full)
                    QuillToolbarLinkStyleButton(
                        controller: controller, options: QuillToolbarLinkStyleButtonOptions(iconTheme: iconTheme, iconSize: iconSize)),
                  if (full) mspw(),
                  // code
                  if (full) QuillToolbarToggleStyleButton(controller: controller, attribute: Attribute.codeBlock, options: options),
                  if (full) mspw(),
                  // divider
                  if (full)
                    AppButton(
                      onPressed: () => addQuillEmbedDividerBlock(),
                      tooltip: 'Insert Divider',
                      noStyling: true,
                      isSquare: true,
                      child: AppIcon(Icons.remove, faded: true),
                    ),
                  if (full) mspw(),
                  // font sizes
                  // if (full) sizeButton('H1', Attribute.h1),
                  // if (full) mspw(),
                  // if (full) sizeButton('H2', Attribute.h2),
                  // if (full) mspw(),
                  // if (full) sizeButton('H3', Attribute.h3),
                  // if (full) mspw(),
                  if (full) sizeButton('H4', Attribute.h4),
                  if (full) mspw(),
                  if (full) sizeButton('H5', Attribute.h5),
                  if (full) mspw(),
                  if (full) sizeButton('H6', Attribute.h6),
                  if (full) mspw(),
                  if (full) sizeButton(' N ', Attribute.header),
                  if (full) mspw(),
                  // image
                  AppButton(
                    onPressed: () => addQuillEmbedImageBlock(),
                    tooltip: 'Insert Image',
                    tooltipDirection: AxisDirection.up,
                    noStyling: true,
                    isSquare: true,
                    child: AppIcon(Icons.image, faded: true),
                  ),
                  // more options
                  tpw(),
                  AppButton(
                    onPressed: () => box.put('${state.views.isChat() ? 'chat' : 'note'}ExpandToolbar', !full),
                    tooltip: full ? 'Minimize' : 'More Styling',
                    tooltipDirection: AxisDirection.up,
                    noStyling: !full,
                    isSquare: true,
                    child: AppIcon(Icons.more_horiz, faded: true),
                  ),
                ],
              ),
            ),
          ],
        );
      });
}
