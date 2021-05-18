import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final String progress;

  const Progress({this.progress = "Loading"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text("Loading")
        ],
      ),
    );
  }
}
