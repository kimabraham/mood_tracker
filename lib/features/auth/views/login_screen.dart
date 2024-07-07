import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routeUrl = '/login';
  static const String routeName = 'login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Login',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
