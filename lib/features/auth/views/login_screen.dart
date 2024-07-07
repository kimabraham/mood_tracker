import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
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
