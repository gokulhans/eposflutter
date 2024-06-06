import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../components/build_container_box.dart';
import '../../../../components/build_round_button.dart';
import '../../../../components/build_text_fields.dart';

import '../../../../providers/grid_provider.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/font_manager.dart';
import '../../../../resources/style_manager.dart';

class AddProductPropertiesScreen extends StatelessWidget {
  final Function(int) navigateToScreen;
  const AddProductPropertiesScreen({super.key, required this.navigateToScreen});

  @override
  Widget build(BuildContext context) {
    //final productPropertiesController = TextEditingController();
    // Define the list of currency
    List<String> property = [
      'Choose Product Properties',
      'brass',
      'bronze',
      "black",
      "white",
    ];

    // Track the selected unit
    String? selectedProperty;
    GridSelectionProvider gridSelectionProvider =
        Provider.of<GridSelectionProvider>(context);
    Size size = MediaQuery.of(context).size;
    //SideBarController sideBarController = Get.put(SideBarController());

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.8,
            width: double.infinity,
            child: BuildBoxShadowContainer(
              circleRadius: 7,
              // margin: const EdgeInsets.only(bottom: 10),
              blurRadius: 6,
              padding: const EdgeInsets.only(
                  left: 10.0, right: 20, top: 30, bottom: 10),
              offsetValue: const Offset(1, 1),

              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildDropDownStatic(
                      selectedItem: selectedProperty,
                      size: size,
                      items: property,
                      hintText: 'Choose Product Properties',
                      title: 'Product Properties',
                      onChanged: (String? newValue) {
                        selectedProperty = newValue!;
                      },
                    ),
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: CustomRoundButton(
                            title: "Prev",
                            boxColor: Colors.white,
                            textColor: ColorManager.kPrimaryColor,
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
                            title: "Submit",
                            fct: () async {
                              navigateToScreen(3);
                              int? productId =
                                  gridSelectionProvider.getProductId;
                              if (productId == null) {
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(SnackBar(
                                      showCloseIcon: true,
                                      dismissDirection: DismissDirection.up,
                                      closeIconColor: Colors.white,
                                      duration: const Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      elevation: 0,
                                      margin: EdgeInsets.only(
                                          top: 50,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.9,
                                          right: 10),
                                      backgroundColor: ColorManager
                                          .kPrimaryColor
                                          .withOpacity(0.6),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      content: Text(
                                        'Failed',
                                        style: buildCustomStyle(
                                            FontWeightManager.medium,
                                            FontSize.s12,
                                            0.12,
                                            Colors.white),
                                      )));
                                // sideBarController.index.value = 14;
                              } else {}
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
        ],
      ),
    );
  }
}
