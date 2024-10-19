import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

import '../../_providers/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../features/_notes/state/quill.dart';
import '../buttons/button.dart';
import '../others/icons.dart';
import '../others/text.dart';
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

  return Wrap(
    alignment: WrapAlignment.end,
    runSpacing: tinyHeight(),
    spacing: smallWidth(),
    children: [
      // undo
      Consumer<QuillProvider>(
        builder: (context, quill, child) => Visibility(
          visible: true,
          child: QuillToolbarHistoryButton(
            controller: controller,
            isUndo: true,
            options: QuillToolbarHistoryButtonOptions(iconTheme: iconTheme, iconSize: iconSize, tooltip: ''),
          ),
        ),
      ),
      // redo
      Consumer<QuillProvider>(
        builder: (context, quill, child) => Visibility(
          visible: true,
          child: QuillToolbarHistoryButton(
            controller: controller,
            isUndo: false,
            options: QuillToolbarHistoryButtonOptions(iconTheme: iconTheme, iconSize: iconSize, tooltip: ''),
          ),
        ),
      ),
      // bold
      QuillToolbarToggleStyleButton(controller: controller, attribute: Attribute.bold, options: options),
      // italic
      QuillToolbarToggleStyleButton(controller: controller, attribute: Attribute.italic, options: options),
      // underline
      QuillToolbarToggleStyleButton(controller: controller, attribute: Attribute.underline, options: options),
      // clear formatting
      QuillToolbarClearFormatButton(controller: controller, options: options),
      // list numbered
      QuillToolbarToggleCheckListButton(
        controller: controller,
        options: QuillToolbarToggleCheckListButtonOptions(iconTheme: iconTheme, iconSize: iconSize),
      ),
      // list bullets
      QuillToolbarToggleStyleButton(controller: controller, attribute: Attribute.ul, options: options),
      // check list
      QuillToolbarToggleStyleButton(controller: controller, attribute: Attribute.ol, options: options),
      // link
      QuillToolbarLinkStyleButton(
          controller: controller, options: QuillToolbarLinkStyleButtonOptions(iconTheme: iconTheme, iconSize: iconSize)),
      // code
      QuillToolbarToggleStyleButton(controller: controller, attribute: Attribute.codeBlock, options: options),
      // divider
      AppButton(
        onPressed: () => addQuillEmbedDividerBlock(),
        tooltip: 'Insert Divider',
        padding: pad(c: 'l6,r6,t14,b14'),
        noStyling: true,
        child: AppButton(color: red, padding: pad(p: 1), width: 30),
      ),
      // font sizes
      sizeButton('H1', Attribute.h4),
      sizeButton('H2', Attribute.h5),
      sizeButton('H3', Attribute.h6),
      sizeButton(' N ', Attribute.header),
      // image
      AppButton(
        onPressed: () => addQuillEmbedImageBlock(),
        tooltip: 'Insert Image',
        tooltipDirection: AxisDirection.up,
        noStyling: true,
        isSquare: true,
        child: AppIcon(Icons.image, faded: true),
      ),
    ],
  );
}
