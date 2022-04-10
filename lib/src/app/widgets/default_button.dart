// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shortly/src/app/constants.dart';

class DefaultButton extends StatelessWidget {
  final Function? onPressed;
  final String text;
  final Color color;

  const DefaultButton({
    required this.onPressed,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
      child: TextButton(
        onPressed: onPressed == null
            ? null
            : () {
                onPressed!();
              },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: kButtonTextStyle(kWhite),
        ),
      ),
    );
  }
}
