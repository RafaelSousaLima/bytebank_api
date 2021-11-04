import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BlocContainer extends StatelessWidget {}

void push(BuildContext buildContext, BlocContainer blocContainer) {
  Navigator.of(buildContext).push(
    MaterialPageRoute(
      builder: (context) => blocContainer,
    ),
  );
}
