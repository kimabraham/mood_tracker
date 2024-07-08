import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/profile/view_models/profile_vm.dart';
import 'package:mood_tracker/features/profile/views/widgets/profile_appbar.dart';
import 'package:mood_tracker/features/profile/views/widgets/profile_button.dart';
import 'package:mood_tracker/features/profile/views/widgets/profile_form.dart';
import 'package:mood_tracker/features/profile/views/widgets/profile_header.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsyncValue = ref.watch(profileProvider);

    return SafeArea(
        child: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: [
                  const ProfileAppbar(),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size24,
                      ),
                      child: profileAsyncValue.when(
                        data: (profile) => const Column(
                          children: [
                            Gaps.v20,
                            ProfileHeader(),
                            ProfileForm(),
                            Gaps.v24,
                            ProfileButton()
                          ],
                        ),
                        error: (error, stackTrace) => Center(
                          child: Text(
                            error.toString(),
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ))
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
