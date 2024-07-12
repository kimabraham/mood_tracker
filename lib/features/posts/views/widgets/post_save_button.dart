import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/constants/mood_colors.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/posts/view_models/post_add_vm.dart';
import 'package:mood_tracker/features/posts/view_models/post_form_vm.dart';

class PostSaveButton extends ConsumerWidget {
  const PostSaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(postAddProvider).isLoading;

    return GestureDetector(
      onTap: isLoading
          ? null
          : () async {
              ref.read(postAddProvider.notifier).createPost();
            },
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size10,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: isLoading
                      ? MoodColors.opacityPrimaryColors[
                          ref.watch(postFormProvider).emotion]
                      : MoodColors
                          .primaryColors[ref.watch(postFormProvider).emotion],
                  borderRadius: BorderRadius.circular(
                    Sizes.size5,
                  )),
              child: const Text(
                'Save',
                style: TextStyle(
                  fontSize: Sizes.size14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
