import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/profile/view_models/profile_vm.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key});

  void _onTapChangeAvatar() {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.read(profileProvider).value!;

    return Column(
      children: [
        Column(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              backgroundImage:
                  const AssetImage('assets/images/default_user.png'),
              radius: Sizes.size64,
            ),
            Transform.translate(
              offset: const Offset(
                0,
                -Sizes.size24,
              ),
              child: GestureDetector(
                onTap: _onTapChangeAvatar,
                child: Container(
                  width: Sizes.size44,
                  height: Sizes.size44,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      border: Border.all(
                        color: Colors.white,
                        width: Sizes.size2,
                      ),
                      shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: const FaIcon(
                    FontAwesomeIcons.pen,
                    color: Colors.white,
                    size: Sizes.size18,
                  ),
                ),
              ),
            )
          ],
        ),
        Transform.translate(
          offset: const Offset(0, -Sizes.size24),
          child: Text(
            profile.name,
            style: TextStyle(
              fontSize: Sizes.size24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
