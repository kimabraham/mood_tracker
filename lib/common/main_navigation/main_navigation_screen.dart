import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_tracker/common/main_navigation/widgets/nav_tab.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/posts/views/post_add_screen.dart';
import 'package:mood_tracker/features/posts/views/posts_list_screen.dart';
import 'package:mood_tracker/features/profile/views/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = 'mainNavigation';
  final String tab;

  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const PostsListScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const PostAddScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const ProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        notchMargin: 5,
        height: Sizes.size56,
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
                    isSelected: _selectedIndex == 0,
                    icon: FontAwesomeIcons.house,
                    onTap: () => _onTap(0),
                    selectedIndex: _selectedIndex,
                  ),
                  Gaps.h96,
                  NavTab(
                    title: 'profile',
                    isSelected: _selectedIndex == 2,
                    icon: FontAwesomeIcons.solidUser,
                    onTap: () => _onTap(2),
                    selectedIndex: _selectedIndex,
                  ),
                ],
              ),
              Positioned(
                // 가운데 플러스 버튼
                left: (MediaQuery.of(context).size.width - Sizes.size72) / 2,
                bottom: 0,
                child: GestureDetector(
                  // 버튼 전체 영역을 터치 가능하게 함
                  onTap: () => _onTap(1), // 플러스 버튼을 누르면 새 게시물 화면으로 이동
                  child: Container(
                    // 버튼 스타일 및 레이아웃 설정
                    width: Sizes.size72,
                    height: Sizes.size72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                      border: Border.all(
                          width: Sizes.size1,
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    alignment: Alignment.center, // 아이콘 가운데 정렬
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
