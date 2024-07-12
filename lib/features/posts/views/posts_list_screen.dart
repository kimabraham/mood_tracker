import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/posts/view_models/post_vm.dart';
import 'package:mood_tracker/features/posts/views/widgets/post_card.dart';

class PostsListScreen extends ConsumerStatefulWidget {
  static const String routeUrl = '/home';
  static const String routeName = 'home';

  const PostsListScreen({super.key});

  @override
  ConsumerState<PostsListScreen> createState() => _PostsListScreenState();
}

class _PostsListScreenState extends ConsumerState<PostsListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postsAsyncValue = ref.watch(postProvider);

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
            postsAsyncValue.when(
                data: (posts) {
                  return Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollEndNotification &&
                            _scrollController.position.extentAfter == 0) {
                          ref.read(postProvider.notifier).fetchNextPage();
                        }
                        return false;
                      },
                      child: ListView.separated(
                        controller: _scrollController,
                        padding: const EdgeInsets.only(
                          bottom: Sizes.size20,
                        ),
                        itemBuilder: (context, index) => PostCard(
                          post: posts[index],
                        ),
                        separatorBuilder: (context, index) => Gaps.v20,
                        itemCount: posts.length,
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) => Center(
                      child: Text(
                        'Error: $error',
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ))
          ],
        ),
      ),
    );
  }
}
