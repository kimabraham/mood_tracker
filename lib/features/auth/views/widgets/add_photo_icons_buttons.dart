import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_tracker/constants/mood_colors.dart';
import 'package:mood_tracker/features/posts/view_models/post_form_vm.dart';

class AddPhotoIconsButtons extends ConsumerWidget {
  const AddPhotoIconsButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(postFormProvider);
    final postFormVm = ref.read(postFormProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: postFormVm.onTapPhotoByCamera,
          icon: FaIcon(
            FontAwesomeIcons.camera,
            color: MoodColors.primaryColors[post.emotion],
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: postFormVm.onTapPhotoByGallery,
          icon: FaIcon(
            FontAwesomeIcons.paperclip,
            color: MoodColors.primaryColors[post.emotion],
          ),
        ),
      ],
    );
  }
}
