import 'package:flutter/material.dart';

class BuildTitle extends StatelessWidget {
  final String title;
  final TextStyle textStyle;

  const BuildTitle({
    Key? key,
    required this.title,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle,
    );
  }
}

class BuildTextTile extends StatelessWidget {
  final String title;
  final TextStyle textStyle;

  const BuildTextTile({
    Key? key,
    required this.title,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 15),
      child: Text(
        title,
        style: textStyle,
      ),
    );
  }
}
