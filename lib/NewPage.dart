import 'package:flutter/material.dart';

class NewPage extends StatelessWidget {
  final String title;

  NewPage({required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Center(
        child: Text('You clicked on the item with title: $title'),
      ),
    );
  }
}
