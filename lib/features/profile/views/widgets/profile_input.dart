import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_tracker/constants/sizes.dart';

class ProfileInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool readOnly;

  const ProfileInputField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    final isPasswordField = hintText.contains('password');

    return TextFormField(
      obscureText: isPasswordField,
      initialValue: isPasswordField ? '' : hintText,
      readOnly: readOnly,
      style: TextStyle(
        fontWeight: isPasswordField ? FontWeight.w400 : FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.inverseSurface,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size14,
          ),
          child: FaIcon(
            icon,
            color: isPasswordField
                ? Theme.of(context).colorScheme.inverseSurface
                : Theme.of(context).colorScheme.onSurface,
          ),
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
