import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';

import '../../__styling/variables.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    this.size,
    required this.text,
    this.fontWeight,
    this.overflow,
    this.color,
    this.textAlign,
    this.textDecoration,
    this.maxlines,
    this.faded = false,
    this.bold = false,
    this.extraFaded = false,
    this.bgColor,
    this.isCrossed = false,
  });

  final double? size;
  final String text;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final Color? color;
  final TextDecoration? textDecoration;
  final int? maxlines;
  final bool bold;
  final bool faded;
  final bool extraFaded;
  final String? bgColor;
  final bool isCrossed;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.visible,
      maxLines: maxlines,
      style: TextStyle(
        fontSize: size ?? 13,
        fontWeight: fontWeight ?? (bold ? FontWeight.bold : FontWeight.w600),
        color: color ?? styler.textColor(faded: faded, extraFaded: extraFaded, bgColor: bgColor),
        decoration: textDecoration ?? (isCrossed ? TextDecoration.lineThrough : null),
        decorationColor: styler.textColor(faded: faded, extraFaded: extraFaded, bgColor: bgColor),
      ),
    );
  }
}

class HtmlText extends StatelessWidget {
  const HtmlText({super.key, this.size = medium, required this.text, this.overflow, this.textAlign, this.color});

  final double size;
  final String text;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return StyledText(
      text: text,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(fontSize: size, fontWeight: FontWeight.w600, color: color ?? styler.textColor()),
      tags: {
        'b': StyledTextTag(
            style: TextStyle(fontWeight: FontWeight.w700, color: color ?? styler.textColor(), fontSize: size)),
      },
    );
  }
}
