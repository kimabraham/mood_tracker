import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile screen',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
