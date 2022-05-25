import 'package:flutter/material.dart';

class ToDayTab extends StatefulWidget {
  const ToDayTab({Key? key}) : super(key: key);
  @override
  _ToDayTabState createState() => _ToDayTabState();
}

class _ToDayTabState extends State<ToDayTab> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('today'),
    );
  }
}
