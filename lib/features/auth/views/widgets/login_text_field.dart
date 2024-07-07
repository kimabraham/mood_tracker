import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_tracker/constants/sizes.dart';

class LoginTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool isObscure;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final Function(String?) onSaved;

  const LoginTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.isObscure,
    required this.focusNode,
    required this.keyboardType,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: Sizes.size2,
          blurRadius: Sizes.size6,
          offset: const Offset(0, 3),
        ),
      ]),
      child: TextFormField(
        onChanged: onSaved,
        onSaved: onSaved,
        focusNode: focusNode,
        obscureText: isObscure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size20,
              vertical: Sizes.size10,
            ), // Adjust padding as needed
            child: FaIcon(
              prefixIcon,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: Sizes.size1,
            ),
            borderRadius: BorderRadius.circular(
              Sizes.size10,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: Sizes.size1,
            ),
            borderRadius: BorderRadius.circular(
              Sizes.size10,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: Sizes.size2,
            ),
            borderRadius: BorderRadius.circular(
              Sizes.size10,
            ),
          ),
        ),
      ),
    );
  }
}
