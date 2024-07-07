import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/auth/views/join_screen.dart';
import 'package:mood_tracker/features/auth/views/widgets/auth_bottom_section.dart';
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
  final ScrollController _scrollController = ScrollController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() => _onFocusChange(_emailFocusNode));
    _passwordFocusNode.addListener(() => _onFocusChange(_passwordFocusNode));
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(() => _onFocusChange(_emailFocusNode));
    _passwordFocusNode.removeListener(() => _onFocusChange(_passwordFocusNode));
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onFocusChange(FocusNode focusNode) {
    if (focusNode.hasFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void _onNavigateToSignup(BuildContext context) {
    context.go(JoinScreen.routeUrl);
  }

  void _onSignup() {
    print('sign up');
  }

  void _onForgotPasswordTap() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size40,
                ),
                scrollDirection: Axis.vertical,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Gaps.v80,
                          const LoginMainImage(),
                          Gaps.v16,
                          const Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: Sizes.size32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Login to your account',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Gaps.v52,
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                LoginTextField(
                                  hintText: 'Email',
                                  isObscure: false,
                                  prefixIcon: FontAwesomeIcons.solidEnvelope,
                                  focusNode: _emailFocusNode,
                                ),
                                Gaps.v20,
                                LoginTextField(
                                  hintText: 'Password',
                                  isObscure: true,
                                  prefixIcon: FontAwesomeIcons.lock,
                                  focusNode: _passwordFocusNode,
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
                          Gaps.v14,
                        ],
                      ),
                      AuthBottomSection(
                        buttonText: 'login',
                        onTap: _onSignup,
                        onNavigateTap: () => _onNavigateToSignup(context),
                        descriptionText: 'Don\'t have an account? ',
                        navigateText: 'Sign up',
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
