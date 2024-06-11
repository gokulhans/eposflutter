import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_machine/components/build_dialog_box.dart';
import 'package:pos_machine/components/build_text_fields.dart';
import 'package:pos_machine/providers/customer_provider.dart';
import 'package:provider/provider.dart';

import '../../components/build_container_box.dart';
import '../../components/build_round_button.dart';
import '../../components/build_title.dart';
import '../../providers/auth_model.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/style_manager.dart';

void showAddCustomerModal(BuildContext context, Size size,
    {String? mobileNumber}) {
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final phoneNumberController = TextEditingController(text: mobileNumber ?? '');
  final addressTextController = TextEditingController();
  final countryTextController = TextEditingController();
  final stateTextController = TextEditingController();
  final cityTextController = TextEditingController();
  final pincodeTextController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            padding: const EdgeInsets.all(16),
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildTextTile(
                    title: "FirstName",
                    textStyle: buildCustomStyle(
                      FontWeightManager.regular,
                      FontSize.s14,
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
                          keyboardType: TextInputType.text,
                          cursorColor: ColorManager.kPrimaryColor,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          controller: firstNameTextController,
                          style: buildCustomStyle(
                            FontWeightManager.medium,
                            FontSize.s12,
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
                          keyboardType: TextInputType.text,
                          cursorColor: ColorManager.kPrimaryColor,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          controller: lastNameTextController,
                          style: buildCustomStyle(
                            FontWeightManager.medium,
                            FontSize.s12,
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
                      FontSize.s14,
                      0.27,
                      Colors.black.withOpacity(0.6),
                    ),
                  ),
                  BuildBoxShadowContainer(
                    circleRadius: 7,
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 20, right: 10),
                    padding: const EdgeInsets.only(left: 15),
                    height: size.height * .07,
                    width: size.width,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validateEmail,
                      cursorColor: ColorManager.kPrimaryColor,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: emailTextController,
                      style: buildCustomStyle(
                        FontWeightManager.medium,
                        FontSize.s12,
                        0.27,
                        ColorManager.textColor.withOpacity(.5),
                      ),
                    ),
                  ),
                  BuildTextTile(
                    title: "Phone Number",
                    textStyle: buildCustomStyle(
                      FontWeightManager.regular,
                      FontSize.s14,
                      0.27,
                      Colors.black.withOpacity(0.6),
                    ),
                  ),
                  BuildBoxShadowContainer(
                    circleRadius: 7,
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 20, right: 10),
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
                        FontSize.s12,
                        0.27,
                        ColorManager.textColor.withOpacity(.5),
                      ),
                    ),
                  ),
                  BuildTextTile(
                    title: "Address",
                    textStyle: buildCustomStyle(
                      FontWeightManager.regular,
                      FontSize.s12,
                      0.27,
                      Colors.black.withOpacity(0.6),
                    ),
                  ),
                  BuildBoxShadowContainer(
                    circleRadius: 7,
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 20, right: 10),
                    padding: const EdgeInsets.only(left: 15),
                    height: size.height * .07,
                    width: size.width,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      cursorColor: ColorManager.kPrimaryColor,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: addressTextController,
                      style: buildCustomStyle(
                        FontWeightManager.medium,
                        FontSize.s12,
                        0.27,
                        ColorManager.textColor.withOpacity(.5),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      buildColumnWidgetForTextFields(
                        controller: countryTextController,
                        height: size.height * .07,
                        width: size.width / 3.05,
                        size: size,
                        isLeft: false,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        readOnly: false,
                        title: "Country",
                        onchanged: (value) {},
                        hintText: "",
                      ),
                      buildColumnWidgetForTextFields(
                        controller: stateTextController,
                        height: size.height * .07,
                        width: size.width / 3.05,
                        size: size,
                        isLeft: true,
                        readOnly: false,
                        title: "State",
                        onchanged: (value) {},
                        hintText: "",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      buildColumnWidgetForTextFields(
                        controller: cityTextController,
                        height: size.height * .07,
                        width: size.width / 3.05,
                        size: size,
                        isLeft: false,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        readOnly: false,
                        title: "City",
                        onchanged: (value) {},
                        hintText: "",
                      ),
                      buildColumnWidgetForTextFields(
                        controller: pincodeTextController,
                        height: size.height * .07,
                        width: size.width / 3.05,
                        size: size,
                        isLeft: true,
                        readOnly: false,
                        title: "Pincode",
                        onchanged: (value) {},
                        hintText: "",
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CustomRoundButtonWithIcon(
                          title: "Add New Customer",
                          fct: () async {
                            if (firstNameTextController.text.isEmpty ||
                                phoneNumberController.text.isEmpty) {
                              showScaffold(
                                context: context,
                                message: 'Please Fill the Required Fields',
                              );
                            } else {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                },
                              );

                              String? accessToken =
                                  Provider.of<AuthModel>(context, listen: false)
                                      .token;
                              await CustomerProvider()
                                  .addCustomer(
                                accessToken ?? "",
                                phoneNumberController.text.replaceAll("-", ""),
                                "1",
                                "${firstNameTextController.text} ${lastNameTextController.text}",
                                emailTextController.text,
                                addressTextController.text,
                                pincodeTextController.text,
                                cityTextController.text,
                                stateTextController.text,
                                countryTextController.text,
                                context,
                              )
                                  .then((value) {
                                Navigator.pop(context);
                                if (value["status"] == "success") {
                                  showScaffold(
                                    context: context,
                                    message: '${value["message"]}',
                                  );

                                  emailTextController.clear();
                                  pincodeTextController.clear();
                                  stateTextController.clear();
                                  phoneNumberController.clear();
                                  lastNameTextController.clear();
                                  firstNameTextController.clear();
                                  addressTextController.clear();
                                  countryTextController.clear();
                                  cityTextController.clear();
                                  Navigator.of(context).pop();
                                } else {
                                  Map<String, dynamic> errorResponse =
                                      value['errors'];
                                  showScaffold(
                                    context: context,
                                    message: errorResponse.values
                                        .map((e) => e.join(''))
                                        .join('\n'),
                                  );
                                }
                              });
                            }
                          },
                          height: 50,
                          width: size.width * 0.19,
                          icon: const Icon(Icons.add, color: Colors.white),
                          fontSize: FontSize.s12,
                          size: size,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CustomRoundButton(
                          title: "Close",
                          boxColor: Colors.white,
                          textColor: ColorManager.kPrimaryColor,
                          fct: () async {
                            Navigator.of(context).pop();
                          },
                          height: 50,
                          width: size.width * 0.19,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      );
    },
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

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String formattedText = formatPhoneNumber(newValue.text);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String formatPhoneNumber(String input) {
    input = input.replaceAll(RegExp(r'\D'), '');
    if (input.length > 3) {
      input = '${input.substring(0, 3)}-${input.substring(3)}';
    }
    if (input.length > 7) {
      input = '${input.substring(0, 7)}-${input.substring(7)}';
    }
    return input;
  }
}
