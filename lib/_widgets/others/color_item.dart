import 'package:flutter/material.dart';

import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_variables/colors.dart';
import 'icons.dart';

class ColorItem extends StatefulWidget {
  const ColorItem({super.key, this.selectedColor, required this.colorKey, this.onSelect});

  final String? selectedColor;
  final String colorKey;
  final Function(String newColor)? onSelect;

  @override
  State<ColorItem> createState() => _ColorItemState();
}

class _ColorItemState extends State<ColorItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        popWhatsOnTop();
        widget.onSelect!(widget.colorKey);
      },
      onHover: (value) => setState(() => isHovered = value),
      customBorder: const CircleBorder(),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: widget.colorKey == 'x' ? styler.appColor(1) : backgroundColors[widget.colorKey]!.color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: AppIcon(
            isHovered ? Icons.lens : (widget.colorKey == 'x' ? Icons.close : Icons.done_rounded),
            size: isHovered ? 10 : 15,
            faded: true,
            color: widget.colorKey == 'x'
                ? null
                : widget.selectedColor == widget.colorKey || isHovered
                    ? backgroundColors[widget.colorKey]!.textColor
                    : transparent,
          ),
        ),
      ),
    );
  }
}
