import 'package:flutter/material.dart';

import '../../components/build_container_box.dart';
import '../../components/build_round_button.dart';
import '../../components/build_title.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/style_manager.dart';

class AddCustomersScreen extends StatelessWidget {
  const AddCustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firstNameTextController = TextEditingController();
    final lastNameTextController = TextEditingController();
    final emailTextController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final addressTextController = TextEditingController();
    final countryTextController = TextEditingController();
    final stateTextController = TextEditingController();
    final cityTextController = TextEditingController();
    final pincodeTextController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
          margin:
              const EdgeInsets.only(left: 10, top: 20, bottom: 0, right: 10),
          padding: const EdgeInsets.all(8),
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
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Customers',
                    style: buildCustomStyle(FontWeightManager.semiBold,
                        FontSize.s20, 0.30, ColorManager.textColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BuildTextTile(
                              title: "FirstName",
                              textStyle: buildCustomStyle(
                                FontWeightManager.regular,
                                FontSize.s18,
                                0.27,
                                Colors.black.withOpacity(0.6),
                              ),
                            ),
                            Row(
                              children: [
                                BuildBoxShadowContainer(
                                  circleRadius: 7,
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  padding: const EdgeInsets.only(left: 15),
                                  height: size.height * .07,
                                  width: size.width / 3.05,
                                  child: TextFormField(
                                    //  initialValue: initialValue,
                                    keyboardType: TextInputType.text,
                                    cursorColor: ColorManager.kPrimaryColor,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    controller: firstNameTextController,
                                    style: buildCustomStyle(
                                      FontWeightManager.medium,
                                      FontSize.s13,
                                      0.27,
                                      ColorManager.textColor.withOpacity(.5),
                                    ),
                                  ),
                                ),
                                BuildBoxShadowContainer(
                                  circleRadius: 7,
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(left: 20),
                                  padding: const EdgeInsets.only(left: 15),
                                  height: size.height * .07,
                                  width: size.width / 3.05,
                                  child: TextFormField(
                                    //  initialValue: initialValue,
                                    keyboardType: TextInputType.text,
                                    cursorColor: ColorManager.kPrimaryColor,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    controller: lastNameTextController,
                                    style: buildCustomStyle(
                                      FontWeightManager.medium,
                                      FontSize.s13,
                                      0.27,
                                      ColorManager.textColor.withOpacity(.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            BuildTextTile(
                              title: "Email Address",
                              textStyle: buildCustomStyle(
                                FontWeightManager.regular,
                                FontSize.s18,
                                0.27,
                                Colors.black.withOpacity(0.6),
                              ),
                            ),
                            BuildBoxShadowContainer(
                              circleRadius: 7,
                              alignment: Alignment.centerLeft,
                              margin:
                                  const EdgeInsets.only(left: 20, right: 10),
                              padding: const EdgeInsets.only(left: 15),
                              height: size.height * .07,
                              width: size.width,
                              child: TextFormField(
                                //  initialValue: initialValue,
                                keyboardType: TextInputType.text,
                                cursorColor: ColorManager.kPrimaryColor,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                controller: emailTextController,
                                style: buildCustomStyle(
                                  FontWeightManager.medium,
                                  FontSize.s13,
                                  0.27,
                                  ColorManager.textColor.withOpacity(.5),
                                ),
                              ),
                            ),
                            BuildTextTile(
                              title: "Phone Number",
                              textStyle: buildCustomStyle(
                                FontWeightManager.regular,
                                FontSize.s18,
                                0.27,
                                Colors.black.withOpacity(0.6),
                              ),
                            ),
                            BuildBoxShadowContainer(
                              circleRadius: 7,
                              alignment: Alignment.centerLeft,
                              margin:
                                  const EdgeInsets.only(left: 20, right: 10),
                              padding: const EdgeInsets.only(left: 15),
                              height: size.height * .07,
                              width: size.width,
                              child: TextFormField(
                                //  initialValue: initialValue,
                                keyboardType: TextInputType.text,
                                cursorColor: ColorManager.kPrimaryColor,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                controller: phoneNumberController,
                                style: buildCustomStyle(
                                  FontWeightManager.medium,
                                  FontSize.s13,
                                  0.27,
                                  ColorManager.textColor.withOpacity(.5),
                                ),
                              ),
                            ),
                            BuildTextTile(
                              title: "Address",
                              textStyle: buildCustomStyle(
                                FontWeightManager.regular,
                                FontSize.s18,
                                0.27,
                                Colors.black.withOpacity(0.6),
                              ),
                            ),
                            BuildBoxShadowContainer(
                              circleRadius: 7,
                              alignment: Alignment.centerLeft,
                              margin:
                                  const EdgeInsets.only(left: 20, right: 10),
                              padding: const EdgeInsets.only(left: 15),
                              height: size.height * .07,
                              width: size.width,
                              child: TextFormField(
                                //  initialValue: initialValue,
                                keyboardType: TextInputType.text,
                                cursorColor: ColorManager.kPrimaryColor,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                controller: addressTextController,
                                style: buildCustomStyle(
                                  FontWeightManager.medium,
                                  FontSize.s13,
                                  0.27,
                                  ColorManager.textColor.withOpacity(.5),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BuildTextTile(
                                      title: "Country",
                                      textStyle: buildCustomStyle(
                                        FontWeightManager.regular,
                                        FontSize.s18,
                                        0.27,
                                        Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                    BuildBoxShadowContainer(
                                      circleRadius: 7,
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      padding: const EdgeInsets.only(left: 15),
                                      height: size.height * .07,
                                      width: size.width / 3.05,
                                      child: TextFormField(
                                        //  initialValue: initialValue,
                                        keyboardType: TextInputType.text,
                                        cursorColor: ColorManager.kPrimaryColor,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        controller: countryTextController,
                                        style: buildCustomStyle(
                                          FontWeightManager.medium,
                                          FontSize.s13,
                                          0.27,
                                          ColorManager.textColor
                                              .withOpacity(.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BuildTextTile(
                                      title: "State",
                                      textStyle: buildCustomStyle(
                                        FontWeightManager.regular,
                                        FontSize.s18,
                                        0.27,
                                        Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                    BuildBoxShadowContainer(
                                      circleRadius: 7,
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(left: 20),
                                      padding: const EdgeInsets.only(left: 15),
                                      height: size.height * .07,
                                      width: size.width / 3.05,
                                      child: TextFormField(
                                        //  initialValue: initialValue,
                                        keyboardType: TextInputType.text,
                                        cursorColor: ColorManager.kPrimaryColor,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        controller: stateTextController,
                                        style: buildCustomStyle(
                                          FontWeightManager.medium,
                                          FontSize.s13,
                                          0.27,
                                          ColorManager.textColor
                                              .withOpacity(.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BuildTextTile(
                                      title: "City",
                                      textStyle: buildCustomStyle(
                                        FontWeightManager.regular,
                                        FontSize.s18,
                                        0.27,
                                        Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                    BuildBoxShadowContainer(
                                      circleRadius: 7,
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      padding: const EdgeInsets.only(left: 15),
                                      height: size.height * .07,
                                      width: size.width / 3.05,
                                      child: TextFormField(
                                        //  initialValue: initialValue,
                                        keyboardType: TextInputType.text,
                                        cursorColor: ColorManager.kPrimaryColor,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        controller: cityTextController,
                                        style: buildCustomStyle(
                                          FontWeightManager.medium,
                                          FontSize.s13,
                                          0.27,
                                          ColorManager.textColor
                                              .withOpacity(.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BuildTextTile(
                                      title: "Pincode",
                                      textStyle: buildCustomStyle(
                                        FontWeightManager.regular,
                                        FontSize.s18,
                                        0.27,
                                        Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                    BuildBoxShadowContainer(
                                      circleRadius: 7,
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(left: 20),
                                      padding: const EdgeInsets.only(left: 15),
                                      height: size.height * .07,
                                      width: size.width / 3.05,
                                      child: TextFormField(
                                        //  initialValue: initialValue,
                                        keyboardType: TextInputType.text,
                                        cursorColor: ColorManager.kPrimaryColor,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        controller: pincodeTextController,
                                        style: buildCustomStyle(
                                          FontWeightManager.medium,
                                          FontSize.s13,
                                          0.27,
                                          ColorManager.textColor
                                              .withOpacity(.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: CustomRoundButtonWithIcon(
                                title: "Add New Customer",
                                fct: () {},
                                height: 50,
                                width: size.width * 0.17,
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                fontSize: FontSize.s12,
                                size: size,
                              ),
                            ),
                            const SizedBox(height: 25),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
