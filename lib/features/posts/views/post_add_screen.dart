import 'package:flutter/material.dart';

class PostAddScreen extends StatelessWidget {
  const PostAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Post add screen',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
