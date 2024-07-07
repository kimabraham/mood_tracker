import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';

class LoginMainImage extends StatelessWidget {
  const LoginMainImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.faceSmile,
              color: Colors.white,
              size: Sizes.size60,
            ),
            Gaps.h10,
            FaIcon(
              FontAwesomeIcons.faceTired,
              color: Colors.white,
              size: Sizes.size60,
            ),
          ],
        ),
        Gaps.v10,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.faceSurprise,
              color: Colors.white,
              size: Sizes.size60,
            ),
            Gaps.h10,
            FaIcon(
              FontAwesomeIcons.faceSadCry,
              color: Colors.white,
              size: Sizes.size60,
            ),
          ],
        ),
      ],
    );
  }
}
