import 'package:flutter/material.dart';

class JoinScreen extends StatelessWidget {
  static const String routeUrl = '/';
  static const String routeName = 'join';
  const JoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Join',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
