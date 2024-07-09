import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/profile/view_models/profile_avatar_vm.dart';

class ProfileHeader extends ConsumerWidget {
  final String uid, name;
  final bool hasAvatar;

  const ProfileHeader({
    super.key,
    required this.uid,
    required this.name,
    required this.hasAvatar,
  });

  Future<void> _onTapChangeAvatar(WidgetRef ref) async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 200,
      maxHeight: 200,
    );

    if (xfile != null) {
      final file = File(xfile.path);
      ref.read(avatarProvider.notifier).uploadAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatarUrl =
        'https://firebasestorage.googleapis.com/v0/b/mood-tracker-abraham.appspot.com/o/avatars%2F$uid?alt=media&time=${DateTime.now().toString()}';
    final isLoading = ref.watch(avatarProvider).isLoading;

    return Column(
      children: [
        Column(
          children: [
            isLoading
                ? Container(
                    width: Sizes.size64 + Sizes.size64,
                    height: Sizes.size64 + Sizes.size64,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const CircularProgressIndicator.adaptive(),
                  )
                : CircleAvatar(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundImage: hasAvatar
                        ? NetworkImage(avatarUrl)
                        : const AssetImage('assets/images/default_user.png'),
                    radius: Sizes.size64,
                    child: const CircularProgressIndicator.adaptive(),
                  ),
            Transform.translate(
              offset: const Offset(
                0,
                -Sizes.size20,
              ),
              child: GestureDetector(
                onTap: isLoading ? null : () => _onTapChangeAvatar(ref),
                child: Container(
                  width: Sizes.size36,
                  height: Sizes.size36,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      border: Border.all(
                        color: Colors.white,
                        width: Sizes.size2,
                      ),
                      shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: const FaIcon(
                    FontAwesomeIcons.arrowsRotate,
                    color: Colors.white,
                    size: Sizes.size18,
                  ),
                ),
              ),
            )
          ],
        ),
        Transform.translate(
          offset: const Offset(0, -Sizes.size16),
          child: Text(
            name.toUpperCase(),
            style: TextStyle(
              fontSize: Sizes.size20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
