import 'package:flutter/material.dart';

import '../../../__styling/helpers.dart';
import '../../../__styling/variables.dart';
import '../../buttons/buttons.dart';
import '../icons.dart';
import '../loader.dart';

class FormInput extends StatefulWidget {
  const FormInput({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.autofocus = false,
    this.isBusy = false,
    this.onFieldSubmitted,
    this.onPressed,
  });

  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final bool isBusy;
  final Function(String)? onFieldSubmitted;
  final Function()? onPressed;

  @override
  State<FormInput> createState() => _EmailFormInputState();
}

class _EmailFormInputState extends State<FormInput> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    bool isPassword = widget.keyboardType == TextInputType.visiblePassword;
    bool showButton = widget.onPressed != null;

    return AppButton(
      color: white,
      height: 34,
      noStyling: true,
      showBorder: true,
      borderWidth: isDark() ? 0.4 : 0.8,
      hoverColor: styler.appColor(0.3),
      borderRadius: borderRadiusTiny,
      padding: const EdgeInsets.all(3),
      child: TextFormField(
        controller: widget.controller,
        autofocus: widget.autofocus,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        textInputAction: widget.textInputAction,
        obscureText: isPassword && hidePassword,
        style: const TextStyle(fontSize: medium, fontWeight: FontWeight.w600),
        cursorColor: styler.accentColor(),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontSize: medium),
          errorStyle: const TextStyle(fontSize: small, fontWeight: FontWeight.w600, color: Colors.red),
          contentPadding: const EdgeInsets.only(left: 7, right: 7),
          border: InputBorder.none,
          isDense: true,
          suffixIcon: showButton || isPassword
              ? AppButton(
                  onPressed: widget.onPressed ?? () => setState(() => hidePassword = !hidePassword),
                  noStyling: isPassword || widget.isBusy,
                  isSquare: true,
                  dryWidth: true,
                  borderRadius: borderRadiusTiny,
                  child: showButton
                      ? widget.isBusy
                          ? AppLoader(color: styler.accentColor())
                          : const AppIcon(Icons.arrow_forward, tiny: true)
                      : AppIcon(hidePassword ? Icons.visibility_rounded : Icons.visibility_off_rounded, faded: true, size: 18),
                )
              : null,
          suffixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
        ),
      ),
    );
  }
}
