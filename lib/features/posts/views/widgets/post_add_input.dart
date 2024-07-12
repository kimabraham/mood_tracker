import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/constants/mood_colors.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/posts/view_models/post_form_vm.dart';

class PostAddInput extends ConsumerWidget {
  final Function(String) onChanged;
  final TextEditingController controller;
  final int? maxLength;
  final int? maxLines;
  final String hintText;
  final String? Function(String?)? validator;

  const PostAddInput({
    super.key,
    required this.onChanged,
    required this.controller,
    required this.hintText,
    this.maxLength,
    this.maxLines,
    required this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: validator,
      style: TextStyle(
        color: MoodColors.darkPrimaryColors[ref.read(postFormProvider).emotion],
        fontSize: Sizes.size14,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Sizes.size8,
          vertical: Sizes.size8,
        ),
        counterText: '',
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: Sizes.size14,
            color: MoodColors
                .darkPrimaryColors[ref.read(postFormProvider).emotion]),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: Sizes.size2,
            style: BorderStyle.solid,
            color: MoodColors
                    .opacityPrimaryColors[ref.read(postFormProvider).emotion] ??
                Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: Sizes.size2,
            style: BorderStyle.solid,
            color:
                MoodColors.primaryColors[ref.read(postFormProvider).emotion] ??
                    Colors.grey,
          ),
        ),
      ),
    );
  }
}
