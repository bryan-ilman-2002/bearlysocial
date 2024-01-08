import 'package:bearlysocial/views/pre_auth/sign_in/page.dart';
import 'package:bearlysocial/views/pre_auth/sign_up/page.dart';
import 'package:flutter/material.dart';

class PreAuthPageManager extends StatefulWidget {
  const PreAuthPageManager({super.key});

  @override
  State<PreAuthPageManager> createState() => _PreAuthPageManager();
}

class _PreAuthPageManager extends State<PreAuthPageManager> {
  List<Widget> _initPages() {
    return <Widget>[
      SignUpPage(
        onTap: _onTab,
      ),
      SignInPage(
        onTap: _onTab,
      ),
    ];
  }

  int _selectedIndex = 0;

  void _onTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pages = [];

  @override
  Widget build(BuildContext context) {
    _pages = _pages.isEmpty ? _initPages() : _pages;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
