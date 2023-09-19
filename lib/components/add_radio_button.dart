import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/style_manager.dart';

enum Gender {
  // ignore: constant_identifier_names
  Male,
  // ignore: constant_identifier_names
  Female,
}

// ignore: must_be_immutable
class AddRadioButton extends StatelessWidget {
  AddRadioButton(
      {super.key,
      required this.title,
      required this.value,
      required this.selectedTypeOfAddressEnum,
      required this.onChanged});
  String title;
  Gender value;
  Gender? selectedTypeOfAddressEnum;
  Function(Gender?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return RadioListTile<Gender>(
        controlAffinity: ListTileControlAffinity.trailing,
        dense: true,
        toggleable: true,
        activeColor: ColorManager.kPrimaryColor,
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: buildCustomStyle(FontWeightManager.regular, FontSize.s12, 0.16,
              Colors.black.withOpacity(0.6)),
        ),
        value: value,
        groupValue: selectedTypeOfAddressEnum,
        onChanged: onChanged);
  }
}
