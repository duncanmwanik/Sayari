import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../_theme/helpers.dart';
import '../../_theme/variables.dart';
import '../others/icons.dart';
import '../others/others/other.dart';

DefaultStyles getQuillEditorStyle({
  bool isOverview = false,
  String? bgColor,
  double fontSize = 15,
}) {
  Color quillTextColor = styler.textColor(bgColor: bgColor);
  Color quillFadedTextColor = styler.textColor(faded: true, bgColor: bgColor);
  FontWeight weight = isDark() ? FontWeight.w400 : FontWeight.w500;
  FontWeight bold = FontWeight.bold;

  return DefaultStyles(
    placeHolder: DefaultTextBlockStyle(
      GoogleFonts.inter(fontSize: isOverview ? fontSize - 4 : fontSize, height: 1.3, color: quillFadedTextColor, fontWeight: weight),
      VerticalSpacing(0, 0),
      VerticalSpacing(0, 0),
      null,
    ),
    leading: DefaultTextBlockStyle(
      GoogleFonts.inter(fontSize: isOverview ? fontSize - 4 : fontSize, height: 1.3, color: quillTextColor, fontWeight: weight),
      VerticalSpacing(0, 0),
      VerticalSpacing(0, 0),
      null,
    ),
    paragraph: DefaultTextBlockStyle(
      GoogleFonts.inter(fontSize: isOverview ? fontSize - 4 : fontSize, height: 1.3, color: quillTextColor, fontWeight: weight),
      VerticalSpacing(0, 0),
      VerticalSpacing(0, 0),
      null,
    ),
    h1: DefaultTextBlockStyle(
      GoogleFonts.inter(
        fontSize: isOverview ? fontSize + 14 : fontSize + 18,
        color: quillTextColor,
        letterSpacing: -1,
        height: 1,
        fontWeight: bold,
        decoration: TextDecoration.none,
      ),
      VerticalSpacing(fontSize, 0),
      VerticalSpacing(0, 0),
      null,
    ),
    h2: DefaultTextBlockStyle(
      GoogleFonts.inter(
        fontSize: isOverview ? fontSize + 10 : fontSize + 14,
        color: quillTextColor,
        letterSpacing: -0.8,
        height: 1.067,
        fontWeight: bold,
        decoration: TextDecoration.none,
      ),
      VerticalSpacing(8, 0),
      VerticalSpacing(0, 0),
      null,
    ),
    h3: DefaultTextBlockStyle(
      GoogleFonts.inter(
        fontSize: isOverview ? fontSize + 4 : 8,
        color: quillTextColor,
        letterSpacing: -0.5,
        height: 1.083,
        fontWeight: bold,
        decoration: TextDecoration.none,
      ),
      VerticalSpacing(0, 0),
      VerticalSpacing(0, 0),
      null,
    ),
    h4: DefaultTextBlockStyle(
      GoogleFonts.inter(
        fontSize: isOverview ? fontSize + 0 : fontSize + 4,
        color: quillTextColor,
        letterSpacing: -0.4,
        height: 1.1,
        fontWeight: bold,
        decoration: TextDecoration.none,
      ),
      VerticalSpacing(0, 0),
      VerticalSpacing(0, 0),
      null,
    ),
    h5: DefaultTextBlockStyle(
      GoogleFonts.inter(
        fontSize: isOverview ? fontSize - 2 : fontSize + 2,
        color: quillTextColor,
        letterSpacing: -0.2,
        height: 1.11,
        fontWeight: bold,
        decoration: TextDecoration.none,
      ),
      VerticalSpacing(0, 0),
      VerticalSpacing(0, 0),
      null,
    ),
    h6: DefaultTextBlockStyle(
      GoogleFonts.inter(
        fontSize: isOverview ? fontSize - 4 : fontSize,
        color: quillTextColor,
        letterSpacing: -0.1,
        height: 1.125,
        fontWeight: bold,
        decoration: TextDecoration.none,
      ),
      VerticalSpacing(0, 0),
      VerticalSpacing(0, 0),
      null,
    ),
    lists: DefaultListBlockStyle(
      GoogleFonts.inter(fontSize: isOverview ? fontSize - 4 : fontSize, height: 1.3, color: quillTextColor, fontWeight: weight),
      VerticalSpacing(6, 0),
      VerticalSpacing(0, 6),
      null,
      CustomQuillCheckbox(isOverview, bgColor),
    ),
    code: DefaultTextBlockStyle(
      GoogleFonts.inter(
        color: quillTextColor,
        fontWeight: weight,
        fontSize: fontSize - 2,
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
    link: GoogleFonts.inter(
      color: styler.accentColor(),
      fontWeight: bold,
    ),
    inlineCode: InlineCodeStyle(
      backgroundColor: styler.appColor(1),
      radius: Radius.circular(borderRadiusSmall),
      style: GoogleFonts.inter(fontSize: 14, color: quillTextColor),
    ),
  );
}

class CustomQuillCheckbox implements QuillCheckboxBuilder {
  CustomQuillCheckbox(this.isOverview, this.bgColor);

  final bool isOverview;
  final String? bgColor;

  @override
  Widget build({required BuildContext context, required bool isChecked, required ValueChanged<bool> onChanged}) {
    return Material(
      color: transparent,
      child: InkWell(
        onTap: () => onChanged(!isChecked),
        borderRadius: BorderRadius.circular(isOverview ? 4 : 5),
        mouseCursor: SystemMouseCursors.click,
        hoverColor: transparent,
        highlightColor: transparent,
        splashColor: transparent,
        child: Container(
          width: 17,
          height: isOverview ? 13 : 17,
          margin: EdgeInsets.symmetric(horizontal: isOverview ? 4.5 : 6.9),
          decoration: BoxDecoration(
            color: isChecked ? styler.accentColor() : null,
            borderRadius: BorderRadius.circular(3),
            border: isChecked ? null : Border.all(color: styler.textColor(faded: true, bgColor: bgColor), width: 1.5),
          ),
          child:
              isChecked ? AppIcon(Icons.done_rounded, size: isOverview ? 8 : 12, faded: true, color: isChecked ? white : null) : NoWidget(),
        ),
      ),
    );
  }
}
