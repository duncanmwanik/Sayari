import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/styler.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/global.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_helpers/forms/form_validation_helper.dart';
import '../../_providers/common/theme.dart';
import '../../_services/firebase/firebase_database.dart';
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
import '_vars/variables.dart';
import 'button.dart';
import 'introduction.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController(text: 'mo@gmail.com');
  final TextEditingController passwordController = TextEditingController(text: '1234567');
  final TextEditingController confirmPasswordController = TextEditingController(text: '1234567');
  final TextEditingController userNameController = TextEditingController(text: 'Mo');

  bool isNewAccount = false;
  bool isSignIn = false;
  bool isResetPassword = false;
  bool isBusy = false;
  bool isDemo = true;

  @override
  Widget build(BuildContext context) {
    changeStatusAndNavigationBarColor(getThemeType());

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
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                height: 100.h,
                alignment: Alignment.center,
                constraints: webMaxConstraints(),
                child: Form(
                  key: signInFormKey,
                  child: Column(
                    children: [
                      //
                      Spacer(),
                      //
                      WelcomeIntro(),
                      //
                      lph(),
                      //
                      if (!isNewAccount && !isSignIn && !isResetPassword)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //
                            SignInButton(
                              onPressed: () => showToast(2, 'Oh this is a demo...', smallTopMargin: true),
                              imagePath: 'assets/images/google.png',
                              label: 'Continue with Google',
                            ),
                            //
                            ph(6),
                            //
                            SignInButton(
                              onPressed: () => showToast(2, 'Oh this is a demo...', smallTopMargin: true),
                              imagePath: 'assets/images/apple.png',
                              label: 'Continue with Apple',
                            ),
                            //
                          ],
                        ),
                      //
                      ph(6),
                      //
                      if (isDemo)
                        SignInButton(
                          onPressed: () async {
                            setState(() => isBusy = true);

                            printThis('Signing in......');
                            await signInUsingEmailPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                            setState(() => isBusy = false);
                          },
                          imagePath: 'assets/images/sayari.png',
                          label: 'Continue to Demo',
                          isLoading: isBusy,
                        ),
                      //
                      if (!isDemo)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //
                            FormInput(
                              hintText: 'Email',
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => Validator.validateEmail(email: value!),
                            ),
                            //
                            ph(6),
                            //
                            if (isNewAccount)
                              FormInput(
                                hintText: 'Username',
                                controller: userNameController,
                                keyboardType: TextInputType.name,
                                validator: (value) => Validator.validateName(name: value!),
                              ),
                            //
                            if (isNewAccount) ph(6),
                            //
                            if (isNewAccount || isSignIn)
                              FormInput(
                                hintText: 'Password',
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: isSignIn ? TextInputAction.done : null,
                                validator: (value) => Validator.validatePassword(password: value!),
                              ),
                            //
                            if (isNewAccount || isSignIn) ph(6),
                            //
                            if (isNewAccount)
                              FormInput(
                                hintText: 'Confirm Password',
                                controller: confirmPasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                validator: (value) => Validator.validatePassword(password: value!),
                              ),
                            //
                            if (isNewAccount) ph(6),
                            //
                            AppButton(
                              onPressed: () async {
                                //
                                hideKeyboard();
                                //
                                if (!isNewAccount && !isSignIn && !isResetPassword && !isBusy) {
                                  if (signInFormKey.currentState!.validate()) {
                                    setState(() => isBusy = true);

                                    String userId = await cloudService.doesUserExist(emailController.text.trim());
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
                                //
                                //
                                if (isNewAccount && !isBusy) {
                                  setState(() => isBusy = true);

                                  printThis('Creating new acc......');
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
                                  printThis('Resetting ps......');
                                  await resetPassword(email: emailController.text.trim());
                                  setState(() => isBusy = false);
                                }
                                //
                              },
                              color: white,
                              width: 220,
                              height: 35,
                              showBorder: !styler.isDark,
                              dryWidth: true,
                              child: Center(
                                child: isBusy
                                    ? AppLoader(color: styler.accentColor())
                                    : AppText(
                                        text: isDemo
                                            ? 'See the Demo'
                                            : isNewAccount
                                                ? 'Sign Up'
                                                : isResetPassword
                                                    ? 'Send Reset Link'
                                                    : isSignIn
                                                        ? 'Sign In'
                                                        : 'Continue',
                                        color: AppColors.lightText,
                                      ),
                              ),
                            ),
                            //
                            sph(),
                            //
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
                                    smallVerticalPadding: true,
                                    label: 'Forgot Password?',
                                  ),
                                //
                                if (isSignIn)
                                  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 2),
                                      child: AppIcon(Icons.lens, size: 5, faded: true)),
                                //
                                if (isNewAccount || isSignIn || isResetPassword)
                                  AppButton(
                                    onPressed: () {
                                      if (isNewAccount || isSignIn || isResetPassword) {
                                        setState(() {
                                          isResetPassword = false;
                                          isSignIn = false;
                                          isNewAccount = false;
                                        });
                                      }
                                    },
                                    noStyling: true,
                                    smallVerticalPadding: true,
                                    label: 'Cancel',
                                  ),
                                //
                              ],
                            ),
                            //
                          ],
                        ),
                      //
                      elph(),
                      //
                      QuickThemeChanger(),
                      //
                      Spacer(),
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
