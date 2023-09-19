import 'package:bearlysocial/specific/pages/sign_in.dart';
import 'package:bearlysocial/specific/pages/sign_up.dart';
import 'package:flutter/material.dart';

class PreAuthPageManager extends StatefulWidget {
  const PreAuthPageManager({super.key});

  @override
  State<PreAuthPageManager> createState() => _PreAuthPageManager();
}

class _PreAuthPageManager extends State<PreAuthPageManager> {
  List<Widget> initPages() {
    return <Widget>[
      SignUp(
        onTap: _onTab,
      ),
      SignIn(
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

  List<Widget> pages = [];

  @override
  Widget build(BuildContext context) {
    pages = pages.isEmpty ? initPages() : pages;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
    );
  }
}
