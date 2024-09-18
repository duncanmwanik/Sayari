import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/global.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_helpers/forms/form_validation_helper.dart';
import '../../_providers/common/theme.dart';
import '../../_variables/intro_features.dart';
import '../../_variables/navigation.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/forms/auth_input.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/loader.dart';
import '../../_widgets/others/text.dart';
import '../../_widgets/others/toast.dart';
import '_helpers/email_signin.dart';
import '_helpers/email_signup.dart';
import '_helpers/reset_password.dart';
import 'button.dart';
import 'intro.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController(); // mo@gmail.com
  final TextEditingController passwordController = TextEditingController(); // 1234567
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  bool isSignIn = true;
  bool isNewAccount = false;
  bool isResetPassword = false;
  bool isBusy = false;
  bool isBusyDemo = false;

  Timer? timer;
  int index = 0;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 5), (_) => setState(() => index = index < introFeatures.length - 1 ? index + 1 : 0));
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusAndNavigationBarColor(getThemeType());

    return Consumer<ThemeProvider>(builder: (context, theme, child) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/${introFeatures[index].title.toLowerCase()}.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.darken,
            ),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Scaffold(
            backgroundColor: transparent,
            body: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Container(
                  margin: paddingL(),
                  constraints: BoxConstraints(maxWidth: 400),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadiusMedium),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                      child: AppButton(
                        borderRadius: borderRadiusMedium,
                        color: styler.appColor(1),
                        padding: paddingL(),
                        child: Form(
                          key: signInFormKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //
                              AuthIntro(
                                index: index,
                                next: () => setState(() => index = index < introFeatures.length - 1 ? index + 1 : 0),
                                previous: () => setState(() => index = index > 0 ? index - 1 : introFeatures.length - 1),
                              ),
                              lph(),
                              //
                              if (!isNewAccount && !isResetPassword)
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //
                                    SignInButton(
                                      onPressed: () => showToast(1, 'Try the demo.', smallTopMargin: true),
                                      imagePath: 'google.png',
                                      label: 'Continue with Google',
                                    ),
                                    ph(6),
                                    SignInButton(
                                      onPressed: () async {
                                        setState(() => isBusyDemo = true);
                                        await signInUsingEmailPassword(email: 'mo@gmail.com', password: '1234567', validate: false);
                                        setState(() => isBusyDemo = false);
                                      },
                                      isBusy: isBusyDemo,
                                      label: 'Try the Demo',
                                    ),
                                    //
                                  ],
                                ),
                              //
                              ph(9),
                              if (!isResetPassword) AppText(text: 'Or continue with email', size: small, extraFaded: true),
                              if (!isResetPassword) ph(9),
                              //
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //
                                  FormInput(
                                    hintText: 'Email',
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) => Validator.validateEmail(email: value!),
                                    isBusy: isBusy,
                                  ),
                                  //
                                  if (isNewAccount) ph(6),
                                  if (isNewAccount)
                                    FormInput(
                                      hintText: 'Username',
                                      controller: userNameController,
                                      keyboardType: TextInputType.name,
                                      validator: (value) => Validator.validateName(name: value!),
                                    ),
                                  //
                                  if (!isResetPassword) ph(6),
                                  if (!isResetPassword)
                                    FormInput(
                                      hintText: 'Password',
                                      controller: passwordController,
                                      keyboardType: TextInputType.visiblePassword,
                                      textInputAction: isSignIn ? TextInputAction.done : null,
                                      validator: (value) => Validator.validatePassword(password: value!),
                                    ),
                                  //
                                  if (isNewAccount) ph(6),
                                  if (isNewAccount)
                                    FormInput(
                                      hintText: 'Confirm Password',
                                      controller: confirmPasswordController,
                                      keyboardType: TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      validator: (value) => Validator.validatePassword(password: value!),
                                    ),
                                  //
                                  ph(6),
                                  AppButton(
                                    onPressed: () async {
                                      //
                                      hideKeyboard();
                                      //
                                      if (isNewAccount && !isBusy) {
                                        setState(() => isBusy = true);

                                        printThis('Creating new account......');
                                        await signUpUsingEmailPassword(
                                          name: userNameController.text.trim(),
                                          email: emailController.text.trim(),
                                          password: passwordController.text.trim(),
                                          confirmPassword: confirmPasswordController.text.trim(),
                                        );
                                        setState(() => isBusy = false);
                                      }
                                      //
                                      //
                                      if (isSignIn && !isBusy) {
                                        setState(() => isBusy = true);

                                        printThis('Signing in......');
                                        await signInUsingEmailPassword(
                                          email: emailController.text.trim(),
                                          password: passwordController.text.trim(),
                                        );
                                        setState(() => isBusy = false);
                                      }
                                      //
                                      //
                                      if (isResetPassword && !isBusy) {
                                        setState(() => isBusy = true);
                                        printThis('Resetting pass......');
                                        await resetPassword(email: emailController.text.trim());
                                        setState(() => isBusy = false);
                                      }
                                      //
                                      //
                                    },
                                    color: styler.appColor(1),
                                    width: 210,
                                    height: 30,
                                    showBorder: true,
                                    hoverColor: isBusy ? transparent : null,
                                    child: Center(
                                      child: isBusy
                                          ? AppLoader(color: styler.accentColor())
                                          : Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Flexible(
                                                  child: AppText(
                                                    text: isNewAccount
                                                        ? 'Sign Up'
                                                        : isResetPassword
                                                            ? 'Send Reset Link'
                                                            : isSignIn
                                                                ? 'Sign In'
                                                                : 'Continue',
                                                    weight: FontWeight.bold,
                                                  ),
                                                ),
                                                mpw(),
                                                AppIcon(Icons.arrow_forward, size: medium),
                                              ],
                                            ),
                                    ),
                                  ),
                                  //
                                  if (isNewAccount || isSignIn || isResetPassword) mph(),
                                  if (isNewAccount || isSignIn || isResetPassword)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        //
                                        if (isSignIn)
                                          AppButton(
                                            onPressed: () {
                                              setState(() {
                                                isResetPassword = true;
                                                isSignIn = false;
                                              });
                                            },
                                            noStyling: true,
                                            child: AppText(text: 'Forgot password?', weight: isDark() ? FontWeight.w400 : null),
                                          ),
                                        //
                                        if (isSignIn)
                                          Expanded(child: AppText(text: '|', size: tiny, extraFaded: true, textAlign: TextAlign.center)),
                                        //
                                        if (isSignIn)
                                          AppButton(
                                            onPressed: () {
                                              setState(() {
                                                isNewAccount = true;
                                                isSignIn = false;
                                              });
                                            },
                                            color: styler.accentColor(0.1),
                                            showBorder: true,
                                            borderColor: styler.accentColor(9),
                                            hoverColor: styler.accentColor(1),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                AppIcon(Icons.person_add, color: styler.accent, size: normal),
                                                spw(),
                                                Flexible(
                                                    child: AppText(
                                                  text: 'Create Account',
                                                  color: styler.accent,
                                                  weight: FontWeight.bold,
                                                )),
                                              ],
                                            ),
                                          ),
                                        //
                                      ],
                                    ),
                                  //
                                  if (isNewAccount || isResetPassword) AppText(text: '•', size: tiny, extraFaded: true),
                                  if (isNewAccount || isResetPassword)
                                    AppButton(
                                      onPressed: () {
                                        setState(() {
                                          isSignIn = true;
                                          isResetPassword = false;
                                          isNewAccount = false;
                                        });
                                      },
                                      noStyling: true,
                                      child: AppText(text: 'Go back', decoration: TextDecoration.underline),
                                    ),
                                  //
                                ],
                              ),
                              //
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
