import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_tracker/common/main_navigation/widgets/nav_tab.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/posts/post_add_screen.dart';
import 'package:mood_tracker/features/posts/posts_list_screen.dart';
import 'package:mood_tracker/features/profile/profile_screen.dart';

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingAddButton(onTap: () => _onTap(1)),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        notchMargin: 5,
        height: Sizes.size56,
        shape: const CircularNotchedRectangle(),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
              color: Colors.grey.shade200,
              width: 1,
            )),
          ),
          child: Row(
            children: [
              NavTab(
                title: 'home',
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                title: 'profile',
                isSelected: _selectedIndex == 2,
                icon: FontAwesomeIcons.solidUser,
                onTap: () => _onTap(2),
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FloatingAddButton extends StatelessWidget {
  final VoidCallback onTap;

  const FloatingAddButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Sizes.size40),
      child: SizedBox(
        width: Sizes.size72,
        height: Sizes.size72,
        child: FloatingActionButton(
          clipBehavior: Clip.antiAlias,
          shape: const CircleBorder(
            side: BorderSide(
              width: Sizes.size1,
              color: Color(0xff2555AA),
            ),
          ),
          backgroundColor: const Color(0xff4B68B0),
          onPressed: onTap,
          elevation: 0,
          highlightElevation: 0,
          child: const FaIcon(
            FontAwesomeIcons.plus,
            color: Colors.white,
            size: Sizes.size28,
          ),
        ),
      ),
    );
  }
}
