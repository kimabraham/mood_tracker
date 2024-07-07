import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/auth/views/join_screen.dart';
import 'package:mood_tracker/features/auth/views/widgets/login_main_image.dart';
import 'package:mood_tracker/features/auth/views/widgets/login_text_field.dart';

class LoginScreen extends StatefulWidget {
  static const String routeUrl = '/';
  static const String routeName = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onNavigateToSignup(BuildContext context) {
    context.push(JoinScreen.routeUrl);
  }

  void _onForgotPasswordTap() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
            vertical: Sizes.size10,
          ),
          child: Column(
            children: [
              Flexible(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LoginMainImage(),
                    Gaps.v16,
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: Sizes.size36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Login to your account',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        color: Colors.white,
                      ),
                    ),
                    Gaps.v20,
                    Form(
                      key: _formKey,
                      child: const Column(
                        children: [
                          LoginTextField(
                            hintText: 'Email',
                            isObscure: false,
                            prefixIcon: FontAwesomeIcons.solidUser,
                          ),
                          Gaps.v20,
                          LoginTextField(
                            hintText: 'Password',
                            isObscure: true,
                            prefixIcon: FontAwesomeIcons.lock,
                          ),
                        ],
                      ),
                    ),
                    Gaps.v14,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: _onForgotPasswordTap,
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: Sizes.size10,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                borderRadius: BorderRadius.circular(
                                  Sizes.size16,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: Sizes.size2,
                                    blurRadius: Sizes.size6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: Sizes.size24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gaps.v14,
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(text: 'Don\'t have an account? '),
                            TextSpan(
                              text: 'Sign up',
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _onNavigateToSignup(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
