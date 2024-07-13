import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/mood_colors.dart';
import 'package:mood_tracker/constants/mood_icons.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/posts/models/post_model.dart';
import 'package:mood_tracker/features/posts/view_models/post_vm.dart';
import 'package:mood_tracker/utils.dart';

class PostCard extends ConsumerWidget {
  final PostModel post;

  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onLongPress: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
            title: const Text(
              'Are you sure you want to delete?',
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                onPressed: () {
                  ref.read(postProvider.notifier).removePost(post.id);
                  context.pop();
                },
                child: const Text('Yes'),
              ),
              CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () => context.pop(),
                child: const Text('No'),
              ),
            ],
          ),
        );
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: Sizes.size96),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size18,
            vertical: Sizes.size8,
          ),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: MoodColors.opacityPrimaryColors[post.emotion],
            border: Border.all(
              width: Sizes.size1,
              color: MoodColors.primaryColors[post.emotion] ?? Colors.grey,
            ),
            borderRadius: BorderRadius.circular(
              Sizes.size10,
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -Sizes.size32,
                right: -Sizes.size32,
                child: FaIcon(
                  MoodIcons.emotionIcons[post.emotion],
                  color: MoodColors.primaryColors[post.emotion],
                  size: Sizes.size80,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: Sizes.size8,
                      ),
                      child: Text(
                        post.title,
                        style: TextStyle(
                          fontSize: Sizes.size18,
                          fontWeight: FontWeight.w500,
                          color: MoodColors.secondaryColors[post.emotion],
                        ),
                      ),
                    ),
                  ),
                  Gaps.v10,
                  Text(
                    post.description,
                    style: TextStyle(
                      color: MoodColors.darkSecondaryColors[post.emotion],
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  Gaps.v10,
                  if (post.images.isNotEmpty)
                    SizedBox(
                      height: Sizes.size96 * 1.5,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 260,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                Sizes.size5,
                              )),
                              child: Image.network(
                                post.images[index],
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Gaps.h10,
                          itemCount: post.images.length),
                    ),
                  Gaps.v10,
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      formatTimeDifference(post.createdAt),
                      style: TextStyle(
                        fontSize: Sizes.size12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
