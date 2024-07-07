import 'package:flutter/material.dart';
import 'package:mood_tracker/constants/sizes.dart';

class NavTab extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final String title;
  final Function() onTap;
  final int selectedIndex;

  const NavTab({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.selectedIndex,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(
            top: Sizes.size18,
          ),
          color: Colors.transparent,
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.4,
            duration: const Duration(milliseconds: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: const Color(0xff4B68B0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
