import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_tracker/common/main_navigation/view_models/navigation_index_vm.dart';
import 'package:mood_tracker/common/main_navigation/widgets/nav_tab.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/posts/views/post_add_screen.dart';
import 'package:mood_tracker/features/posts/views/posts_list_screen.dart';
import 'package:mood_tracker/features/profile/views/profile_screen.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  static const String routeName = 'mainNavigation';
  final String tab;

  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  ConsumerState<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(navigationProvider);
    final onTap = ref.read(navigationProvider.notifier).setIndex;

    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: selectedIndex != 0,
            child: const PostsListScreen(),
          ),
          Offstage(
            offstage: selectedIndex != 1,
            child: const PostAddScreen(),
          ),
          Offstage(
            offstage: selectedIndex != 2,
            child: const ProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        notchMargin: 5,
        height: Sizes.size60,
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                children: [
                  NavTab(
                    title: 'home',
                    isSelected: selectedIndex == 0,
                    icon: FontAwesomeIcons.house,
                    onTap: () => onTap(0),
                    selectedIndex: selectedIndex,
                  ),
                  Gaps.h96,
                  NavTab(
                    title: 'profile',
                    isSelected: selectedIndex == 2,
                    icon: FontAwesomeIcons.solidUser,
                    onTap: () => onTap(2),
                    selectedIndex: selectedIndex,
                  ),
                ],
              ),
              Positioned(
                left: (MediaQuery.of(context).size.width - Sizes.size72) / 2,
                bottom: Sizes.size10,
                child: GestureDetector(
                  onTap: () => onTap(1),
                  child: Container(
                    width: Sizes.size64,
                    height: Sizes.size64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                      border: Border.all(
                          width: Sizes.size1,
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    alignment: Alignment.center,
                    child: const FaIcon(
                      FontAwesomeIcons.plus,
                      color: Colors.white,
                      size: Sizes.size28,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
