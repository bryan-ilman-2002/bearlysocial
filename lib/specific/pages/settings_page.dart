import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final ScrollController controller;

  const SettingsPage({
    super.key,
    required this.controller,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<Widget> _children = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          controller: widget.controller,
          itemCount: _children.length,
          itemBuilder: (BuildContext context, int index) => _children[index],
        ),
      ),
    );
  }
}
