import 'package:flutter/material.dart';

import '../../../components/build_container_box.dart';
import '../../../components/build_round_button.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';

class ViewProductPropertiesScreen extends StatelessWidget {
  final Function(int) navigateToScreen;
  const ViewProductPropertiesScreen(
      {super.key, required this.navigateToScreen});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: size.height * 0.8,
        width: double.infinity,
        child: BuildBoxShadowContainer(
          circleRadius: 7,
          // margin: const EdgeInsets.only(bottom: 10),
          blurRadius: 6,
          padding:
              const EdgeInsets.only(left: 10.0, right: 20, top: 30, bottom: 10),
          offsetValue: const Offset(1, 1),

          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 50),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: CustomRoundButton(
                    title: "Prev",
                    fct: () async {
                      navigateToScreen(1);
                      // sideBarController.index.value = 14;
                    },
                    height: 50,
                    width: size.width * 0.19,
                    fontSize: FontSize.s12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: CustomRoundButton(
                    title: "Next",
                    boxColor: Colors.white,
                    textColor: ColorManager.kPrimaryColor,
                    fct: () async {
                      navigateToScreen(3);
                      //   sideBarController.index.value = 14;
                    },
                    height: 50,
                    width: size.width * 0.19,
                    fontSize: FontSize.s12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
          ]),
        ),
      ),
    ]));
  }
}
