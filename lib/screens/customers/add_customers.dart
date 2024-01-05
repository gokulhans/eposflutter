import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_machine/providers/customer_provider.dart';
import 'package:provider/provider.dart';

import '../../components/build_container_box.dart';
import '../../components/build_round_button.dart';
import '../../components/build_title.dart';
import '../../providers/auth_model.dart';
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: validateEmail,
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
                                keyboardType: TextInputType.number,
                                inputFormatters: [PhoneNumberFormatter()],
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
                                fct: () async {
                                  debugPrint("Add New Customer");
                                  debugPrint(phoneNumberController.text
                                      .replaceAll("-", ""));
                                  if (firstNameTextController.text.isEmpty ||
                                      lastNameTextController.text.isEmpty ||
                                      emailTextController.text.isEmpty ||
                                      phoneNumberController.text.isEmpty ||
                                      addressTextController.text.isEmpty ||
                                      countryTextController.text.isEmpty ||
                                      pincodeTextController.text.isEmpty ||
                                      stateTextController.text.isEmpty ||
                                      cityTextController.text.isEmpty) {
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
                                            'Please Fill the Required Fields',
                                            style: buildCustomStyle(
                                                FontWeightManager.medium,
                                                FontSize.s12,
                                                0.12,
                                                Colors.white),
                                          )));
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return const Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          );
                                        });

                                    String? accessToken =
                                        Provider.of<AuthModel>(context,
                                                listen: false)
                                            .token;
                                    debugPrint(
                                        "accessToken From AuthModel $accessToken");
                                    await CustomerProvider()
                                        .addCustomer(
                                            accessToken ?? "",
                                            phoneNumberController.text
                                                .replaceAll("-", ""),
                                            "1",
                                            "${firstNameTextController.text} ${lastNameTextController.text}",
                                            emailTextController.text,
                                            addressTextController.text,
                                            pincodeTextController.text,
                                            cityTextController.text,
                                            stateTextController.text,
                                            countryTextController.text,
                                            context)
                                        .then((value) {
                                      if (value["status"] == "success") {
                                        ScaffoldMessenger.of(context)
                                          ..removeCurrentSnackBar()
                                          ..showSnackBar(SnackBar(
                                              showCloseIcon: true,
                                              dismissDirection:
                                                  DismissDirection.up,
                                              closeIconColor: Colors.white,
                                              duration:
                                                  const Duration(seconds: 2),
                                              behavior:
                                                  SnackBarBehavior.floating,
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
                                                      BorderRadius.circular(
                                                          10)),
                                              content: Text(
                                                '${value["message"]}',
                                                style: buildCustomStyle(
                                                    FontWeightManager.medium,
                                                    FontSize.s12,
                                                    0.12,
                                                    Colors.white),
                                              )));
                                        Navigator.pop(context);
                                        emailTextController.clear();
                                        pincodeTextController.clear();
                                        stateTextController.clear();
                                        phoneNumberController.clear();
                                        lastNameTextController.clear();
                                        firstNameTextController.clear();
                                        addressTextController.clear();
                                        countryTextController.clear();
                                        cityTextController.clear();
                                      } else {
                                        Map<String, dynamic> errorResponse =
                                            value['errors'];
                                        debugPrint(
                                            errorResponse.values.map((e) {
                                          return e.join('');
                                        }).join('\n'));

                                        debugPrint("errors.password !=null");
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                          ..removeCurrentSnackBar()
                                          ..showSnackBar(SnackBar(
                                              showCloseIcon: true,
                                              dismissDirection:
                                                  DismissDirection.up,
                                              closeIconColor: Colors.white,
                                              duration:
                                                  const Duration(seconds: 2),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              elevation: 0,
                                              margin: const EdgeInsets.only(
                                                  top: 50, left: 50, right: 10),
                                              backgroundColor: ColorManager
                                                  .kPrimaryColor
                                                  .withOpacity(0.6),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              content: Text(
                                                errorResponse.values.map((e) {
                                                  return e.join('');
                                                }).join('\n'),
                                                style: buildCustomStyle(
                                                    FontWeightManager.medium,
                                                    FontSize.s12,
                                                    0.12,
                                                    Colors.white),
                                              )));
                                      }
                                    });
                                  }
                                },
                                height: 50,
                                width: size.width * 0.19,
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

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Implement your phone number formatting logic here
    String formattedText = formatPhoneNumber(newValue.text);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String formatPhoneNumber(String input) {
    // Implement your phone number formatting logic here
    // This is a basic example; you can customize it based on your requirements
    input =
        input.replaceAll(RegExp(r'\D'), ''); // Remove non-numeric characters
    if (input.length > 3) {
      input = '${input.substring(0, 3)}-${input.substring(3)}';
    }
    if (input.length > 7) {
      input = '${input.substring(0, 7)}-${input.substring(7)}';
    }
    return input;
  }
}
