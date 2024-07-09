import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/profile/view_models/profile_vm.dart';

class ProfileButton extends ConsumerWidget {
  final Future<void> Function() onTap;

  const ProfileButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileNotifier = ref.read(profileProvider.notifier);
    final isLoading = profileNotifier.isLoading;

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size12,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: isLoading
                      ? Colors.grey.shade400
                      : Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(
                    Sizes.size10,
                  )),
              child: const Text(
                'Save',
                style: TextStyle(
                  fontSize: Sizes.size18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
