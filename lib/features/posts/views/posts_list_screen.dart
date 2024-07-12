import 'package:flutter/cupertino.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/posts/models/post_model.dart';
import 'package:mood_tracker/features/posts/views/widgets/post_card.dart';

class PostsListScreen extends StatelessWidget {
  static const String routeUrl = '/home';
  static const String routeName = 'home';

  PostsListScreen({super.key});

  final mockPost = PostModel(
      id: '123',
      title: 'Today is happy day :)',
      description:
          'description_description_description_description_description_description_description_description_description_description_description_description_description_description_description_description_description_description_description_description',
      creator: 'kim',
      creatorUid: '123123',
      emotion: Mood.joy,
      createdAt: 123123,
      updatedAt: 123123);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size24,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size20,
              ),
              child: CupertinoSearchTextField(
                onChanged: (value) {},
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(
                  bottom: Sizes.size20,
                ),
                itemBuilder: (context, index) => PostCard(
                  post: mockPost,
                ),
                separatorBuilder: (context, index) => Gaps.v10,
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
