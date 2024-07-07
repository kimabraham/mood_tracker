import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';

class AuthBottomSection extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final VoidCallback onNavigateTap;
  final String descriptionText;
  final String navigateText;

  const AuthBottomSection({
    super.key,
    required this.buttonText,
    required this.onTap,
    required this.onNavigateTap,
    required this.descriptionText,
    required this.navigateText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: AuthButton(onTap: onTap, buttonText: buttonText),
            ),
          ],
        ),
        Gaps.v14,
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: descriptionText),
              TextSpan(
                text: navigateText,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()..onTap = onNavigateTap,
              ),
            ],
          ),
        ),
        Gaps.v14,
      ],
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.onTap,
    required this.buttonText,
  });

  final VoidCallback onTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          borderRadius: BorderRadius.circular(
            Sizes.size16,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: Sizes.size2,
              blurRadius: Sizes.size6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          buttonText.toUpperCase(),
          style: const TextStyle(
            fontSize: Sizes.size20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
