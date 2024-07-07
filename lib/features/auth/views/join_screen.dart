import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/auth/views/login_screen.dart';
import 'package:mood_tracker/features/auth/views/widgets/auth_bottom_section.dart';
import 'package:mood_tracker/features/auth/views/widgets/login_text_field.dart';

class JoinScreen extends StatefulWidget {
  static const String routeUrl = '/join';
  static const String routeName = 'join';
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() => _onFocusChange(_emailFocusNode));
    _usernameFocusNode.addListener(() => _onFocusChange(_usernameFocusNode));
    _passwordFocusNode.addListener(() => _onFocusChange(_passwordFocusNode));
    _confirmPasswordFocusNode
        .addListener(() => _onFocusChange(_confirmPasswordFocusNode));
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(() => _onFocusChange(_emailFocusNode));
    _usernameFocusNode.removeListener(() => _onFocusChange(_usernameFocusNode));
    _passwordFocusNode.removeListener(() => _onFocusChange(_passwordFocusNode));
    _confirmPasswordFocusNode
        .removeListener(() => _onFocusChange(_confirmPasswordFocusNode));
    _emailFocusNode.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
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

  void _onNavigateToLogin(BuildContext context) {
    context.go(LoginScreen.routeUrl);
  }

  void _onJoin() {
    print('join');
  }

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
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Gaps.v96,
                          const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: Sizes.size32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Create your account',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Gaps.v72,
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                LoginTextField(
                                  hintText: 'Email address',
                                  isObscure: false,
                                  prefixIcon: FontAwesomeIcons.solidEnvelope,
                                  focusNode: _emailFocusNode,
                                ),
                                Gaps.v20,
                                LoginTextField(
                                  hintText: 'Username',
                                  isObscure: false,
                                  prefixIcon: FontAwesomeIcons.solidUser,
                                  focusNode: _usernameFocusNode,
                                ),
                                Gaps.v20,
                                LoginTextField(
                                  hintText: 'Password',
                                  isObscure: true,
                                  prefixIcon: FontAwesomeIcons.lock,
                                  focusNode: _passwordFocusNode,
                                ),
                                Gaps.v20,
                                LoginTextField(
                                  hintText: 'Confirm password',
                                  isObscure: true,
                                  prefixIcon: FontAwesomeIcons.lock,
                                  focusNode: _confirmPasswordFocusNode,
                                ),
                                Gaps.v14,
                                const Text(
                                  'By registering you are agreeing to our Terms of use and Privacy Policy.',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Gaps.v14,
                              ],
                            ),
                          ),
                        ],
                      ),
                      AuthBottomSection(
                        buttonText: 'register',
                        onTap: _onJoin,
                        onNavigateTap: () => _onNavigateToLogin(context),
                        descriptionText: 'Already have an account? ',
                        navigateText: 'Login',
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
