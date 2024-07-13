import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/common/main_navigation/view_models/navigation_index_vm.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/auth/repositories/auth_repo.dart';
import 'package:mood_tracker/features/auth/views/login_screen.dart';

class ProfileAppbar extends ConsumerWidget {
  const ProfileAppbar({
    super.key,
  });

  void _onTapLogout(BuildContext context, WidgetRef ref) {
    ref.read(authRepoProvider).logout();
    ref.read(navigationProvider.notifier).setIndex(0);
    context.go(LoginScreen.routeUrl);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Gaps.h48,
        const Text(
          'My profile',
          style: TextStyle(
            fontSize: Sizes.size20,
          ),
        ),
        IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () => _onTapLogout(context, ref),
          icon: const FaIcon(
            FontAwesomeIcons.rightFromBracket,
          ),
        ),
      ],
    );
  }
}
