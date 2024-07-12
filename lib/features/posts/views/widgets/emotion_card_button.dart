import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/mood_colors.dart';
import 'package:mood_tracker/constants/mood_icons.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/posts/models/post_model.dart';

class EmotionCardButton extends StatelessWidget {
  final Mood emotion;
  final Function() onTap;
  final bool isCurrent;

  const EmotionCardButton({
    super.key,
    required this.emotion,
    required this.onTap,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Sizes.size80,
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size6,
          vertical: Sizes.size6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Sizes.size5,
          ),
          color: MoodColors.opacityPrimaryColors[emotion],
          border: Border.all(
            width: Sizes.size4,
            color: isCurrent
                ? MoodColors.primaryColors[emotion] ?? Colors.transparent
                : Colors.transparent,
          ),
        ),
        child: Column(
          children: [
            FaIcon(
              MoodIcons.emotionIcons[emotion],
              color: MoodColors.primaryColors[emotion],
              size: Sizes.size32,
            ),
            Gaps.v5,
            Text(
              '${emotion.toString().split('.').last[0].toUpperCase()}${emotion.toString().split('.').last.substring(1)}',
              style: TextStyle(
                color: MoodColors.darkPrimaryColors[emotion],
                fontSize: Sizes.size12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
