import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/_providers.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../state/quill.dart';
import 'embed_divider.dart';
import 'embed_image.dart';

Widget getQuillToolbar() {
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

  return Consumer<QuillProvider>(builder: (context, quill, child) {
    bool full = quill.fullToolbar;

    return Wrap(
      alignment: WrapAlignment.end,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: tinyHeight(),
      children: [
        // QuillToolbarCustomButton(
        //   controller: controller,
        //   options: QuillToolbarCustomButtonOptions(
        //     icon: AppText(text: 'Co', weight: FontWeight.bold),
        //     iconTheme: iconTheme,
        //     onPressed: () => print(controller.document.toDelta()),
        //   ),
        // ),
        //
        // undo
        if (full)
          QuillToolbarHistoryButton(
            controller: controller,
            isUndo: true,
            options: QuillToolbarHistoryButtonOptions(iconTheme: iconTheme, iconSize: iconSize),
          ),
        if (full) mspw(),
        // redo
        if (full)
          QuillToolbarHistoryButton(
            controller: controller,
            isUndo: false,
            options: QuillToolbarHistoryButtonOptions(iconTheme: iconTheme, iconSize: iconSize),
          ),
        if (full) mspw(),
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
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.image, faded: true),
        ),
        // more options
        tpw(),
        AppButton(
          onPressed: () => quill.showFullToolBar(!full),
          tooltip: full ? 'Minimize' : 'More Styling',
          noStyling: !full,
          isSquare: true,
          child: AppIcon(full ? Icons.close_rounded : Icons.more_horiz, faded: true),
        ),
      ],
    );
  });
}
