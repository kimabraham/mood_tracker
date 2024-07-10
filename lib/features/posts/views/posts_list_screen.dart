import 'package:flutter/cupertino.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/posts/models/post_model.dart';
import 'package:mood_tracker/features/posts/views/widgets/post_card.dart';

class PostsListScreen extends StatelessWidget {
  static const String routeUrl = '/home';
  static const String routeName = 'home';

  const PostsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size24,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Gaps.v10,
            CupertinoSearchTextField(
              onChanged: (value) {},
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size20,
                ),
                itemBuilder: (context, index) => const PostCard(
                  emotion: Mood.anger,
                ),
                separatorBuilder: (context, index) => Gaps.v20,
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
