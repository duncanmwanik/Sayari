import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../__styling/styler.dart';
import '../../../__styling/variables.dart';
import '../../abcs/buttons/buttons.dart';
import '../icons.dart';
import '../others/dry_intrinsic_size.dart';

class FormInput extends StatefulWidget {
  const FormInput({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.autofocus = false,
  });

  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autofocus;

  @override
  State<FormInput> createState() => _EmailFormInputState();
}

class _EmailFormInputState extends State<FormInput> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    bool isPassword = widget.keyboardType == TextInputType.visiblePassword;

    return AppButton(
      color: white,
      width: 220,
      height: 35,
      dryWidth: true,
      showBorder: !styler.isDark,
      hoverColor: styler.appColor(0.3),
      child: DryIntrinsicWidth(
        child: TextFormField(
          controller: widget.controller,
          autofocus: widget.autofocus,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          textInputAction: widget.textInputAction,
          obscureText: isPassword && hidePassword,
          textAlignVertical: TextAlignVertical.center,
           style: TextStyle(
              fontSize: medium,
              fontWeight: FontWeight.w600,
              color: AppColors.lightText),
          cursorColor: styler.accentColor(),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle:
                TextStyle(fontSize: medium, color: AppColors.lightTextFaded),
            errorStyle: TextStyle(
                fontSize: small,
                fontWeight: FontWeight.w700,
                color: styler.textColor()),
            contentPadding: EdgeInsets.only(left: 5, top:kIsWeb? 5:0, right: isPassword ? 0 : 5),
            border: InputBorder.none,
            isDense: true,
            suffixIcon: isPassword
                ? InkWell(
                    onTap: () => setState(() => hidePassword = !hidePassword),
                    customBorder: CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: AppIcon(
                          hidePassword
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          size: 18,
                          color: AppColors.lightTextFaded),
                    ),
                  )
                : null,
            suffixIconConstraints: BoxConstraints(minHeight: 0, minWidth: 0),
          ),
        ),
      ),
    );
  }
}
