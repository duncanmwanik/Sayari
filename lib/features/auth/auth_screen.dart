import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/styler.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/global.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_helpers/forms/form_validation_helper.dart';
import '../../_providers/common/theme.dart';
import '../../_services/firebase/database.dart';
import '../../_variables/navigation.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/others/forms/auth_input.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/loader.dart';
import '../../_widgets/others/text.dart';
import '../../_widgets/others/theme.dart';
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

  bool isNewAccount = false;
  bool isSignIn = false;
  bool isResetPassword = false;
  bool isBusy = false;
  bool isBusyDemo = false;

  Future<void> checkEmail([String? email]) async {
    hideKeyboard();
    if (signInFormKey.currentState!.validate() && !isBusy) {
      setState(() => isBusy = true);

      String userId = await cloudService.doesUserExist(email ?? emailController.text.trim());
      if (userId.isEmpty) {
        printThis('User does not exist......');
        setState(() => isNewAccount = true);
      } else {
        printThis('User exists......');
        setState(() => isSignIn = true);
      }
      setState(() => isBusy = false);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    changeStatusAndNavigationBarColor(getThemeType());
    bool doCheckEmail = !isNewAccount && !isSignIn && !isResetPassword;

    return Consumer<ThemeProvider>(builder: (context, theme, child) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(getDefaultThemeImage()),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: transparent,
          body: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Container(
                constraints: webMaxConstraints(),
                child: Form(
                  key: signInFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //
                      AuthIntro(),
                      //
                      lph(),
                      //
                      if (!isNewAccount && !isSignIn && !isResetPassword)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //
                            SignInButton(
                              onPressed: () => showToast(2, "Let's try the demo...", smallTopMargin: true),
                              imagePath: 'assets/images/google.png',
                              label: 'Continue with Google',
                            ),
                            //
                          ],
                        ),
                      //
                      ph(6),
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
                            onFieldSubmitted: doCheckEmail ? (email) async => await checkEmail(email.trim()) : null,
                            onPressed: doCheckEmail ? () async => await checkEmail() : null,
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
                          if (isNewAccount || isSignIn) ph(6),
                          if (isNewAccount || isSignIn)
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
                          if (isNewAccount || isSignIn || isResetPassword) ph(6),
                          if (isNewAccount || isSignIn || isResetPassword)
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
                              color: Color.alphaBlend(styler.accentColor(3), white),
                              width: 210,
                              height: 30,
                              showBorder: !styler.isDark,
                              dryWidth: true,
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
                                              color: AppColors.lightText,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          spw(),
                                          AppIcon(Icons.arrow_forward, size: normal, color: AppColors.lightText),
                                        ],
                                      ),
                              ),
                            ),
                          //
                          if (isNewAccount || isSignIn || isResetPassword) sph(),
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
                                        isNewAccount = false;
                                      });
                                    },
                                    noStyling: true,
                                    smallVerticalPadding: true,
                                    borderRadius: borderRadiusLarge,
                                    child: AppText(text: 'Forgot Password?', fontWeight: isDark() ? FontWeight.w400 : null),
                                  ),
                                //
                                if (isSignIn)
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 2), child: AppIcon(Icons.lens, size: 5, faded: true)),
                                //
                                AppButton(
                                  onPressed: () {
                                    setState(() {
                                      isResetPassword = false;
                                      isSignIn = false;
                                      isNewAccount = false;
                                    });
                                  },
                                  noStyling: true,
                                  smallVerticalPadding: true,
                                  borderRadius: borderRadiusLarge,
                                  child: AppText(text: 'Cancel', fontWeight: isDark() ? FontWeight.w400 : null),
                                ),
                                //
                              ],
                            ),
                          //
                          if (doCheckEmail) ph(12),
                          if (doCheckEmail)
                            AppButton(
                              onPressed: () async {
                                setState(() => isBusyDemo = true);
                                printThis('Signing in to demo......');
                                await signInUsingEmailPassword(email: 'mo@gmail.com', password: '1234567', validate: false);
                                setState(() => isBusyDemo = false);
                              },
                              noStyling: true,
                              dryWidth: true,
                              borderRadius: borderRadiusTiny,
                              child: isBusyDemo
                                  ? AppLoader(color: styler.accentColor())
                                  : AppText(text: 'Try the Demo', fontWeight: isDark() ? FontWeight.w400 : null),
                            ),
                          //
                        ],
                      ),
                      //
                      mph(),
                      //
                      QuickThemeChanger(rightPadding: false),
                      //
                    ],
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
