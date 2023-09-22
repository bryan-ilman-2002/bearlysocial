import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:flutter/material.dart';

class MainNavigationBar extends StatelessWidget {
  final List<dynamic> navItems;
  final int selectedIndex;
  final Function(int) onTap;

  const MainNavigationBar({
    super.key,
    required this.navItems,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: navItems.asMap().entries.map((entry) {
          final label = entry.value[0] as String;
          final highlightedIcon = entry.value[1] as IconData;
          final normalIcon = entry.value[2] as IconData;
          return _navItemBuilder(label, normalIcon, highlightedIcon, entry.key);
        }).toList(),
      ),
    );
  }

  Widget _navItemBuilder(
      String label, IconData normalIcon, IconData highlightedIcon, int index) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onTap(index);
        },
        child: SizedBox(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                selectedIndex == index ? highlightedIcon : normalIcon,
                color: selectedIndex == index ? heavyGray : moderateGray,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: selectedIndex == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: selectedIndex == index ? heavyGray : moderateGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
