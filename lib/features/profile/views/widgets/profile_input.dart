import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_tracker/constants/sizes.dart';

class ProfileInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool readOnly;
  final String initValue;

  const ProfileInputField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.readOnly,
    required this.initValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initValue,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size14,
          ),
          child: FaIcon(icon),
        ),
        prefixIconConstraints: const BoxConstraints(maxHeight: 48),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Sizes.size24,
          vertical: Sizes.size16,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            style: BorderStyle.none,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(
            Sizes.size10,
          ),
        ),
      ),
    );
  }
}
