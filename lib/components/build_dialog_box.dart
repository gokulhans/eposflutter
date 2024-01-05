import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/style_manager.dart';
import 'build_round_button.dart';

void showErrorDialog({required String error, required BuildContext ctx}) {
  showCupertinoDialog(
      barrierDismissible: true,
      context: ctx,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.error_outline_rounded,
                  color: ColorManager.kPrimaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error Occurred ',
                  style: buildCustomStyle(FontWeightManager.bold, FontSize.s13,
                      0.11, ColorManager.kPrimaryColor),
                ),
              ),
            ],
          ),
          content: Text(
            error,
            style: buildCustomStyle(FontWeightManager.medium, FontSize.s13,
                0.11, ColorManager.textColor),
          ),
          actions: [
            Center(
              child: CustomRoundButton(
                  title: "Ok",
                  fct: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  radius: 10,
                  height: 40,
                  width: 100,
                  fontSize: FontSize.s12),
            ),
          ],
        );
      });
}
