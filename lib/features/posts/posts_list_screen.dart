import 'package:flutter/material.dart';

class PostsListScreen extends StatelessWidget {
  const PostsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Post list screen',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
