import 'package:bearlysocial/views/pre_auth/pre_auth_page.dart';
import 'package:flutter/material.dart';

class PreAuthPageManager extends StatefulWidget {
  /// [PreAuthPageManager] is a [StatefulWidget] managing the pre-authentication pages,
  /// allowing users to navigate between sign-up and sign-in pages using an [IndexedStack].

  const PreAuthPageManager({super.key});

  @override
  State<PreAuthPageManager> createState() => _PreAuthPageManager();
}

class _PreAuthPageManager extends State<PreAuthPageManager> {
  List<Widget> _pages = [];

  int _selectedIndex = 0;

  List<Widget> _initPages() {
    return <Widget>[
      PreAuthenticationPage(
        onTap: _onTab,
        accountCreation: true, // sign-up page
      ),
      PreAuthenticationPage(
        onTap: _onTab,
        accountCreation: false, // sign-in page
      ),
    ];
  }

  void _onTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _pages = _initPages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
