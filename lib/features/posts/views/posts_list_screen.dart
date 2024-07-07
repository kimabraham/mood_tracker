import 'package:flutter/material.dart';

class PostsListScreen extends StatelessWidget {
  static const String routeUrl = '/home';
  static const String routeName = 'home';

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
