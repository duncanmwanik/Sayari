import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/providers.dart';
import '../icons.dart';

class DataInput extends StatefulWidget {
  const DataInput({
    super.key,
    this.controller,
    this.inputKey = '',
    required this.hintText,
    this.initialValue,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTapOutside,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.minLines = 1,
    this.maxLines,
    this.autofocus = false,
    this.enabled = true,
    this.isDense = true,
    this.filled = true,
    this.isNumerals = false,
    this.isPassword = false,
    this.color,
    this.textColor,
    this.bgColor,
    this.fontWeight = FontWeight.w600,
    this.contentPadding,
    this.fontSize = medium,
    this.borderRadius = borderRadiusSmall,
    this.prefix,
  });

  final TextEditingController? controller;
  final String inputKey;
  final String hintText;
  final String? initialValue;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function(PointerDownEvent)? onTapOutside;
  final Function()? onTap;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final int minLines;
  final int? maxLines;
  final bool autofocus;
  final bool enabled;
  final bool isDense;
  final bool filled;
  final bool isNumerals;
  final bool isPassword;
  final Color? color;
  final Color? textColor;
  final String? bgColor;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry? contentPadding;
  final double fontSize;
  final double borderRadius;
  final Widget? prefix;

  @override
  State<DataInput> createState() => _DataInputState();
}

class _DataInputState extends State<DataInput> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      mouseCursor: widget.enabled ? null : SystemMouseCursors.click,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged ?? (widget.controller == null ? (value) => state.input.update(action: 'add', key: widget.inputKey, value: value.trim()) : null),
      onFieldSubmitted: widget.onFieldSubmitted,
      onTapOutside: widget.onTapOutside,
      onTap: widget.onTap,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      initialValue: widget.controller == null ? widget.initialValue ?? state.input.data[widget.inputKey] : null,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.isNumerals ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))] : null,
      style: TextStyle(fontSize: widget.fontSize, color: widget.textColor ?? styler.textColor(bgColor: widget.bgColor), fontWeight: widget.fontWeight),
      textAlignVertical: TextAlignVertical.center,
      cursorColor: styler.accentColor(),
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: widget.contentPadding,
        hintStyle: TextStyle(fontSize: widget.fontSize, color: widget.textColor ?? styler.textColor(faded: true, bgColor: widget.bgColor), fontWeight: widget.fontWeight),
        isDense: widget.isDense,
        filled: widget.filled,
        fillColor: widget.color ?? styler.appColor(1),
        hoverColor: styler.appColor(0.5),
        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(widget.borderRadius)),
        prefixIcon: widget.prefix,
        suffixIcon: widget.isPassword
            ? InkWell(
                onTap: () => setState(() => showPassword = !showPassword),
                customBorder: CircleBorder(),
                child: Padding(
                  padding: itemPadding(),
                  child: AppIcon(
                    showPassword ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                    faded: true,
                  ),
                ))
            : null,
        suffixIconConstraints: BoxConstraints(minHeight: 0, minWidth: 0),
      ),
    );
  }
}
