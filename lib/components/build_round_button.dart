import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../responsive.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final Function fct;
  final Size size;
  const RoundButton(
      {Key? key, required this.title, required this.fct, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * .07,
      decoration: BoxDecoration(
        color: ColorManager.kPrimaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: MaterialButton(
        onPressed: () {
          fct();
        },
        child: Text(
          title,
          style: const TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.semiBold,
              color: Colors.white),
        ),
      ),
    );
  }
}

class RoundButtonWithIcon extends StatelessWidget {
  final String title;
  final Function fct;
  final Size size;
  final String iconPath;
  const RoundButtonWithIcon(
      {Key? key,
      required this.title,
      required this.fct,
      required this.size,
      required this.iconPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 200,
      height: size.height * .055,
      margin: ResponsiveWidget.isTablet(context)
          ? const EdgeInsets.only(left: 10)
          : const EdgeInsets.only(left: 20),
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: ColorManager.kPrimaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: MaterialButton(
        onPressed: () {
          fct();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WebsafeSvg.asset(iconPath, color: Colors.white),
            const SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontFamily: FontConstants.fontFamily,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.medium,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRoundButton extends StatelessWidget {
  final String title;
  final Function fct;
  final double fontSize;
  final double height;
  final double width;
  final Color? boxColor;
  final Color? borderColor;
  final Color? textColor;
  final double? radius;
  const CustomRoundButton({
    Key? key,
    required this.title,
    required this.fct,
    required this.height,
    required this.width,
    required this.fontSize,
    this.boxColor,
    this.textColor,
    this.radius,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? ColorManager.kPrimaryColor),
        color: boxColor ?? ColorManager.kPrimaryColor,
        borderRadius: BorderRadius.circular(radius ?? 5),
      ),
      child: MaterialButton(
        onPressed: () {
          fct();
        },
        child: Text(
          title,
          style: TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontSize: fontSize,
              fontWeight: FontWeightManager.semiBold,
              color: textColor ?? Colors.white),
        ),
      ),
    );
  }
}
