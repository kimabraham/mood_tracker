import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/profile/view_models/profile_vm.dart';
import 'package:mood_tracker/features/profile/views/widgets/profile_input.dart';

class ProfileForm extends ConsumerWidget {
  const ProfileForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.read(profileProvider).value!;

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileInputField(
            hintText: "Email",
            icon: FontAwesomeIcons.envelope,
            readOnly: true,
            initValue: profile.email,
          ),
          Gaps.v10,
          ProfileInputField(
            hintText: "Username",
            icon: FontAwesomeIcons.user,
            readOnly: true,
            initValue: profile.name,
          ),
          Gaps.v28,
          Text(
            'Change password',
            style: TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
          ),
          Gaps.v10,
          const ProfileInputField(
            hintText: "Enter old password",
            icon: FontAwesomeIcons.lock,
            readOnly: false,
            initValue: '',
          ),
          Gaps.v10,
          const ProfileInputField(
            hintText: "Enter new password",
            icon: FontAwesomeIcons.lock,
            readOnly: false,
            initValue: '',
          ),
        ],
      ),
    );
  }
}
