import 'package:flutter/material.dart';

import '../resources/font_manager.dart';
import '../resources/style_manager.dart';
import 'build_title.dart';

class BuildPaymentRow extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  final double? padding;
  final TextStyle? firstRowTextStyle;
  final TextStyle? secondtRowTextStyle;
  const BuildPaymentRow({
    Key? key,
    required this.title,
    required this.amount,
    required this.color,
    this.secondtRowTextStyle,
    this.padding,
    this.firstRowTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BuildTitle(
          title: title,
          textStyle: firstRowTextStyle ??
              buildCustomStyle(
                FontWeightManager.medium,
                FontSize.s12,
                0.18,
                color,
              ),
        ),
        BuildTitle(
          title: amount,
          textStyle: secondtRowTextStyle ??
              buildCustomStyle(
                FontWeightManager.medium,
                FontSize.s12,
                0.18,
                color,
              ),
        ),
      ],
    );
  }
}
