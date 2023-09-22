import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/specific/nav_bars/main_nav_bar.dart';
import 'package:bearlysocial/specific/pages/chats_page.dart';
import 'package:bearlysocial/specific/pages/explore_page.dart';
import 'package:bearlysocial/specific/pages/favorites_page.dart';
import 'package:bearlysocial/specific/pages/sessions_page.dart';
import 'package:bearlysocial/specific/pages/settings_page.dart';
import 'package:flutter/material.dart';

class PostAuthPageManager extends StatefulWidget {
  const PostAuthPageManager({super.key});

  @override
  State<PostAuthPageManager> createState() => _PostAuthPageManager();
}

class _PostAuthPageManager extends State<PostAuthPageManager> {
  bool _scrollButtonIsShown = false;
  late ScrollController _scrollController;

  void _scrollListener(bool condition, ScrollController pageScrollController) {
    setState(() {
      _scrollButtonIsShown = condition;
      _scrollController = pageScrollController;
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOut,
    );
  }

  int _selectedIndex = 0;

  void _onTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pages = [];

  List<Widget> initPostAuthPages(
      Function(bool, ScrollController) scrollListener) {
    return <Widget>[
      ExplorePage(
        controller: _createPageScrollController(scrollListener),
      ),
      FavoritesPage(
        controller: _createPageScrollController(scrollListener),
      ),
      SessionsPage(
        controller: _createPageScrollController(scrollListener),
      ),
      ChatsPage(
        controller: _createPageScrollController(scrollListener),
      ),
      SettingsPage(
        controller: _createPageScrollController(scrollListener),
      ),
    ];
  }

  ScrollController _createPageScrollController(
      Function(bool, ScrollController) scrollListener) {
    final scrollController = ScrollController();
    scrollController.addListener(
      () => scrollListener(scrollController.offset > 0, scrollController),
    );
    return scrollController;
  }

  @override
  Widget build(BuildContext context) {
    _pages = _pages.isEmpty ? initPostAuthPages(_scrollListener) : _pages;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: MainNavigationBar(
        navItems: const [
          ['Explore', Icons.explore, Icons.explore_outlined],
          ['Favorites', Icons.favorite, Icons.favorite_border],
          ['Sessions', Icons.calendar_today, Icons.calendar_today_outlined],
          ['Chats', Icons.chat, Icons.chat_outlined],
          ['Settings', Icons.settings, Icons.settings_outlined],
        ],
        selectedIndex: _selectedIndex,
        onTap: _onTab,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      floatingActionButton: _scrollButtonIsShown
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              elevation: 1.6,
              backgroundColor: Colors.white,
              mini: true,
              child: Icon(
                Icons.arrow_upward,
                size: 24,
                color: moderateGray,
              ),
            )
          : null,
    );
  }
}
