import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../../__styling/variables.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/others/other_widgets.dart';

DefaultStyles getQuillEditorStyle({bool isOverview = false, String? bgColor}) {
  Color quillTextColor = styler.textColor(bgColor: bgColor);
  Color quillFadedTextColor = styler.textColor(faded: true, bgColor: bgColor);
  FontWeight fontWeight = FontWeight.w500;
  FontWeight boldFontWeight = FontWeight.w700;
  String fontFamily = 'Nunito';

  return DefaultStyles(
    placeHolder: DefaultTextBlockStyle(
      TextStyle(
          fontSize: isOverview ? 13 : 16,
          height: 1.3,
          color: quillFadedTextColor,
          fontFamily: fontFamily,
          fontWeight: fontWeight),
      VerticalSpacing(0, 0),
      VerticalSpacing(0, 0),
      null,
    ),
    leading: DefaultTextBlockStyle(
      TextStyle(
          fontSize: isOverview ? 13 : 16,
          height: 1.3,
          color: quillTextColor,
          fontFamily: fontFamily,
          fontWeight: fontWeight),
      VerticalSpacing(0, 0),
      VerticalSpacing(0, 0),
      null,
    ),
    paragraph: DefaultTextBlockStyle(
      TextStyle(
          fontSize: isOverview ? 13 : 16,
          height: 1.3,
          color: quillTextColor,
          fontFamily: fontFamily,
          fontWeight: fontWeight),
      VerticalSpacing(0, 0),
      VerticalSpacing(0, 0),
      null,
    ),
    h1: DefaultTextBlockStyle(
      TextStyle(
        fontSize: isOverview ? 31 : 34,
        color: quillTextColor,
        letterSpacing: -1,
        height: 1,
        fontWeight: boldFontWeight,
        decoration: TextDecoration.none,
        fontFamily: fontFamily,
      ),
      VerticalSpacing(16, 0),
      VerticalSpacing(0, 0),
      null,
    ),
    h2: DefaultTextBlockStyle(
      TextStyle(
        fontSize: isOverview ? 27 : 30,
        color: quillTextColor,
        letterSpacing: -0.8,
        height: 1.067,
        fontWeight: boldFontWeight,
        decoration: TextDecoration.none,
        fontFamily: fontFamily,
      ),
      VerticalSpacing(8, 0),
      VerticalSpacing(0, 0),
      null,
    ),
    h3: DefaultTextBlockStyle(
      TextStyle(
        fontSize: isOverview ? 21 : 24,
        color: quillTextColor,
        letterSpacing: -0.5,
        height: 1.083,
        fontWeight: boldFontWeight,
        decoration: TextDecoration.none,
        fontFamily: fontFamily,
      ),
      VerticalSpacing(0, 0),
      VerticalSpacing(0, 0),
      null,
    ),
    h4: DefaultTextBlockStyle(
      TextStyle(
        fontSize: isOverview ? 17 : 20,
        color: quillTextColor,
        letterSpacing: -0.4,
        height: 1.1,
        fontWeight: boldFontWeight,
        decoration: TextDecoration.none,
        fontFamily: fontFamily,
      ),
      VerticalSpacing(0, 0),
      VerticalSpacing(0, 0),
      null,
    ),
    h5: DefaultTextBlockStyle(
      TextStyle(
        fontSize: isOverview ? 15 : 18,
        color: quillTextColor,
        letterSpacing: -0.2,
        height: 1.11,
        fontWeight: boldFontWeight,
        decoration: TextDecoration.none,
        fontFamily: fontFamily,
      ),
      VerticalSpacing(0, 0),
      VerticalSpacing(0, 0),
      null,
    ),
    h6: DefaultTextBlockStyle(
      TextStyle(
        fontSize: isOverview ? 13 : 16,
        color: quillTextColor,
        letterSpacing: -0.1,
        height: 1.125,
        fontWeight: boldFontWeight,
        decoration: TextDecoration.none,
        fontFamily: fontFamily,
      ),
      VerticalSpacing(0, 0),
      VerticalSpacing(0, 0),
      null,
    ),
    lists: DefaultListBlockStyle(
      TextStyle(
          fontSize: isOverview ? 13 : 16,
          height: 1.3,
          color: quillTextColor,
          fontFamily: fontFamily,
          fontWeight: fontWeight),
      VerticalSpacing(6, 0),
      VerticalSpacing(0, 6),
      null,
      CustomQuillCheckbox(isOverview, bgColor),
    ),
    code: DefaultTextBlockStyle(
      TextStyle(
        color: quillTextColor,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        fontSize: 13,
        height: 1.15,
      ),
      VerticalSpacing(6, 0),
      VerticalSpacing(0, 0),
      BoxDecoration(
        color: styler.appColor(1),
        borderRadius: BorderRadius.circular(borderRadiusSmall),
        border: Border.all(color: quillTextColor.withOpacity(0.05), width: 1),
      ),
    ),
    link: TextStyle(
      color: styler.accentColor(),
      fontWeight: boldFontWeight,
    ),
    inlineCode: InlineCodeStyle(
      backgroundColor: styler.appColor(1),
      radius: Radius.circular(borderRadiusSmall),
      style: TextStyle(
          fontSize: 14, color: quillTextColor, fontFamily: fontFamily),
    ),
  );
}

class CustomQuillCheckbox implements QuillCheckboxBuilder {
  CustomQuillCheckbox(this.isOverview, this.bgColor);

  final bool isOverview;
  final String? bgColor;

  @override
  Widget build(
      {required BuildContext context,
      required bool isChecked,
      required ValueChanged<bool> onChanged}) {
    return Material(
      color: transparent,
      child: InkWell(
        onTap: () => onChanged(!isChecked),
        borderRadius: BorderRadius.circular(isOverview ? 4 : 5),
        mouseCursor: SystemMouseCursors.click,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: isOverview ? 15 : 17),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: isOverview ? 5.5 : 6.5),
            decoration: BoxDecoration(
              color: isChecked ? styler.accentColor() : null,
              borderRadius: BorderRadius.circular(isOverview ? 4 : 5),
              border: isChecked
                  ? null
                  : Border.all(
                      color: styler.textColor(faded: true, bgColor: bgColor),
                      width: 1.5),
            ),
            child: Center(
              child: isChecked
                  ? AppIcon(Icons.done_rounded,
                      size: isOverview ? 8 : 12,
                      faded: true,
                      color: isChecked ? white : null)
                  : NoWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
