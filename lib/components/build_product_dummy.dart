import 'package:flutter/material.dart';

import '../resources/color_manager.dart';

class BuildProductDummy extends StatelessWidget {
  const BuildProductDummy({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: const [
                    BoxShadow(
                      color: ColorManager.boxShadowColor,
                      blurRadius: 6,
                      offset: Offset(1, 1),
                    ),
                  ],
                  color: ColorManager.colorPlaceholder),
            ),
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
      ),
    );
  }
}
