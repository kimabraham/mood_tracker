import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/mood_colors.dart';
import 'package:mood_tracker/constants/mood_icons.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/posts/models/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: Sizes.size96),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size10,
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
            Sizes.size20,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -Sizes.size28,
              right: -Sizes.size20,
              child: FaIcon(
                MoodIcons.emotionIcons[post.emotion],
                color: MoodColors.primaryColors[post.emotion],
                size: Sizes.size72,
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
                        fontSize: Sizes.size22,
                        fontWeight: FontWeight.w500,
                        color: MoodColors.secondaryColors[post.emotion],
                      ),
                    ),
                  ),
                ),
                Gaps.v20,
                Text(
                  post.description,
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: MoodColors.darkSecondaryColors[post.emotion],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                Gaps.v16,
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${post.createdAt}',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
