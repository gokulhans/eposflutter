import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';

TextStyle buildCustomStyle(FontWeight fontWeight, double fontSize,
        double letterSpacing, Color color) =>
    TextStyle(
      overflow: TextOverflow.ellipsis,
      fontWeight: fontWeight,
      fontFamily: FontConstants.fontFamily,
      fontSize: fontSize,
      letterSpacing: 0.16,
      color: color,
    );
TextStyle buildHeaderStyle = const TextStyle(
  overflow: TextOverflow.ellipsis,
  fontWeight: FontWeightManager.semiBold,
  fontFamily: FontConstants.fontFamily,
  fontSize: FontSize.s20,
  letterSpacing: 0.30,
  color: ColorManager.textColor,
);
TextStyle buildTitleStyle = const TextStyle(
  overflow: TextOverflow.ellipsis,
  fontWeight: FontWeightManager.semiBold,
  fontFamily: FontConstants.fontFamily,
  fontSize: FontSize.s20,
  letterSpacing: 0.30,
  color: Colors.black,
);
TextStyle buildTextFieldStyle = const TextStyle(
  fontWeight: FontWeightManager.regular,
  overflow: TextOverflow.ellipsis,
  fontFamily: FontConstants.fontFamily,
  fontSize: FontSize.s10,
  letterSpacing: 0.16,
  color: ColorManager.grey,
);
TextStyle buildTextTileStyle = const TextStyle(
  overflow: TextOverflow.ellipsis,
  fontWeight: FontWeightManager.regular,
  fontFamily: FontConstants.fontFamily,
  fontSize: FontSize.s10,
  letterSpacing: 0.16,
  color: ColorManager.textColor,
);
InputDecoration decoration = InputDecoration(
  //border: InputBorder.none,
  enabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(width: 0.4, color: ColorManager.grey.withOpacity(0.7)),
      borderRadius: BorderRadius.circular(6)),
  disabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(width: 0.4, color: ColorManager.grey.withOpacity(0.7)),
      borderRadius: BorderRadius.circular(6)),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 0.3, color: Colors.red),
      borderRadius: BorderRadius.circular(6)),
  errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 0.3, color: Colors.red),
      borderRadius: BorderRadius.circular(6)),
  focusedBorder: OutlineInputBorder(
      borderSide:
          BorderSide(width: 0.4, color: ColorManager.grey.withOpacity(0.7)),
      borderRadius: BorderRadius.circular(6)),
  border: OutlineInputBorder(
      borderSide:
          BorderSide(width: 0.4, color: ColorManager.grey.withOpacity(0.7)),
      borderRadius: BorderRadius.circular(6)),
);
InputDecoration decorationBorder = InputDecoration(
  //border: InputBorder.none,
  enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 0.4, color: Colors.black),
      borderRadius: BorderRadius.circular(6)),
  disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 0.4, color: Colors.black),
      borderRadius: BorderRadius.circular(6)),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 0.3, color: Colors.red),
      borderRadius: BorderRadius.circular(6)),
  errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 0.3, color: Colors.red),
      borderRadius: BorderRadius.circular(6)),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 0.4, color: Colors.black),
      borderRadius: BorderRadius.circular(6)),
  border: OutlineInputBorder(
      borderSide: const BorderSide(width: 0.4, color: Colors.black),
      borderRadius: BorderRadius.circular(6)),
);
