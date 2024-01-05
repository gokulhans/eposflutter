import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';

class BuildOrderDetailsDummy extends StatelessWidget {
  const BuildOrderDetailsDummy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 30,
                    width: size.width / 2.5,
                    color: ColorManager.colorPlaceholder),
                Container(
                    margin: const EdgeInsets.only(bottom: 13),
                    height: 10,
                    width: size.width / 3.5,
                    color: ColorManager.colorPlaceholder),
                Container(
                    height: 10,
                    width: 100,
                    margin: const EdgeInsets.only(bottom: 3),
                    color: ColorManager.colorPlaceholder),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10, right: 20),
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: ColorManager.kPrimaryColor.withOpacity(0.5)),
                  boxShadow: const [
                    BoxShadow(
                      color: ColorManager.boxShadowColor,
                      blurRadius: 6,
                      offset: Offset(1, 1),
                    ),
                  ],
                  color: Colors.white),
              child: Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.boxShadowColor,
                        blurRadius: 6,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: ColorManager.colorPlaceholder),
              ),
            ),
          ],
        ),
        Container(
            margin: const EdgeInsets.only(bottom: 3),
            height: 10,
            width: 80,
            color: ColorManager.colorPlaceholder),
        Container(
            height: 7,
            width: 50,
            margin: const EdgeInsets.only(bottom: 3),
            color: ColorManager.colorPlaceholder),
        Container(height: 5, width: 30, color: ColorManager.colorPlaceholder),
      ],
    );
  }
}
