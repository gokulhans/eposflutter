import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';

import 'package:pos_machine/providers/authentication_providers.dart';

import '../../components/build_round_button.dart';
import '../../components/build_title.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/style_manager.dart';
import 'login.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _obscureConfirmText = false;

  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();

  String? otpCode;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();

    super.dispose();
  }

  void clear() {
    _passwordTextController.clear();
    _confirmPasswordTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * .1,
                  ),
                  BuildTextTile(
                    title: 'Reset Password',
                    textStyle: buildTitleStyle,
                  ),
                  SizedBox(
                    height: height * .08,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Pinput(
                            length: 6,
                            showCursor: true,
                            defaultPinTheme: PinTheme(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: ColorManager.kPrimaryColor
                                          .withOpacity(0.5))),
                              textStyle: buildCustomStyle(
                                  FontWeightManager.medium,
                                  FontSize.s12,
                                  0.12,
                                  ColorManager.kPrimaryColor),
                            ),
                            onCompleted: ((value) {
                              setState(() {
                                debugPrint("OnCompleted");
                                otpCode = value;
                              });
                            }),
                            onSubmitted: ((value) {
                              debugPrint("OnCompleted");
                              setState(() {
                                otpCode = value;
                              });
                            }),
                            onChanged: (value) => setState(() {
                              otpCode = value;
                            }),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: size.width / 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                key: const Key("Password_Sign_in"),
                                obscureText: _obscureText,
                                cursorColor: ColorManager.kPrimaryColor,
                                controller: _passwordTextController,
                                cursorHeight: 15,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  RegExp regex = RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                  if (value!.isEmpty) {
                                    return 'Please enter password here';
                                  } else {
                                    if (!regex.hasMatch(value)) {
                                      return 'Enter valid password';
                                    } else {
                                      return null;
                                    }
                                  }
                                },
                                decoration: decoration.copyWith(
                                  hintText: '*******',
                                  iconColor: ColorManager.kPrimaryWithOpacity10,
                                  prefixIcon: Icon(
                                    Icons.lock_clock_rounded,
                                    color: ColorManager.kPrimaryColor
                                        .withOpacity(0.5),
                                  ),
                                  hintStyle: buildTextFieldStyle,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: ColorManager.kPrimaryColor
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width / 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 20),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                key: const Key("Confirm_Password_Sign_in"),
                                obscureText: _obscureConfirmText,
                                cursorColor: ColorManager.kPrimaryColor,
                                controller: _confirmPasswordTextController,
                                cursorHeight: 15,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter password here';
                                  } else {
                                    if (_passwordTextController.text != value) {
                                      return 'Password doesnot match';
                                    } else {
                                      return null;
                                    }
                                  }
                                },
                                decoration: decoration.copyWith(
                                  hintText: 'Repeat Password',
                                  iconColor: ColorManager.kPrimaryWithOpacity10,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: ColorManager.kPrimaryColor
                                        .withOpacity(0.5),
                                  ),
                                  hintStyle: buildTextFieldStyle,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureConfirmText =
                                            !_obscureConfirmText;
                                      });
                                    },
                                    child: Icon(
                                      _obscureConfirmText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: ColorManager.kPrimaryColor
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: ColorManager.kPrimaryColor,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 5),
                                  child: CustomRoundButton(
                                    width: width / 2,
                                    fontSize: FontSize.s12,
                                    height: size.height * .07,
                                    key: const Key("Button_Sign_in"),
                                    title: 'Verify',
                                    fct: () async {
                                      if (_passwordTextController
                                          .text.isNotEmpty) {
                                        debugPrint("hello");
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) {
                                              return const Center(
                                                child: CircularProgressIndicator
                                                    .adaptive(),
                                              );
                                            });
                                        debugPrint(otpCode);
                                        await AuthenticationProvider()
                                            .resetPassword(
                                                otpCode ?? '',
                                                _passwordTextController.text,
                                                _confirmPasswordTextController
                                                    .text,
                                                context)
                                            .then((value) async {
                                          // Navigator.pop(context);
                                          if (value["status"] == "success") {
                                            ScaffoldMessenger.of(context)
                                              ..removeCurrentSnackBar()
                                              ..showSnackBar(SnackBar(
                                                  showCloseIcon: true,
                                                  dismissDirection:
                                                      DismissDirection.up,
                                                  closeIconColor: Colors.white,
                                                  duration: const Duration(
                                                      seconds: 2),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  elevation: 0,
                                                  margin: EdgeInsets.only(
                                                      top: 50,
                                                      left:
                                                          MediaQuery.of(context)
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
                                                        FontWeightManager
                                                            .medium,
                                                        FontSize.s12,
                                                        0.12,
                                                        Colors.white),
                                                  )));
                                            Navigator.pop(context);
                                            await Future.delayed(
                                                    const Duration(seconds: 1))
                                                .then((value) => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const SignInScreen())));
                                          } else {
                                            Map<String, dynamic> errorResponse =
                                                value['errors'];
                                            debugPrint(
                                                errorResponse.values.map((e) {
                                              return e.join('');
                                            }).join('\n'));

                                            debugPrint(
                                                "errors.password !=null");
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                              ..removeCurrentSnackBar()
                                              ..showSnackBar(SnackBar(
                                                  showCloseIcon: true,
                                                  dismissDirection:
                                                      DismissDirection.up,
                                                  closeIconColor: Colors.white,
                                                  duration: const Duration(
                                                      seconds: 2),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  elevation: 0,
                                                  margin: const EdgeInsets.only(
                                                      top: 50,
                                                      left: 50,
                                                      right: 10),
                                                  backgroundColor: ColorManager
                                                      .kPrimaryColor
                                                      .withOpacity(0.6),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  content: Text(
                                                    errorResponse.values
                                                        .map((e) {
                                                      return e.join('');
                                                    }).join('\n'),
                                                    style: buildCustomStyle(
                                                        FontWeightManager
                                                            .medium,
                                                        FontSize.s12,
                                                        0.12,
                                                        Colors.white),
                                                  )));
                                          }
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                          ..removeCurrentSnackBar()
                                          ..showSnackBar(SnackBar(
                                              duration:
                                                  const Duration(seconds: 10),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              elevation: 0,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              backgroundColor: ColorManager
                                                  .kPrimaryColor
                                                  .withOpacity(0.6),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              content: Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  const Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                            '\nPlease Fill Details!\n'),
                                                      ),
                                                    ],
                                                  ),
                                                  Positioned(
                                                    top: -10,
                                                    right: -5,
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          ScaffoldMessenger.of(
                                                              context)
                                                            ..hideCurrentSnackBar(),
                                                      child: Container(
                                                        height: 25,
                                                        width: 25,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: ColorManager
                                                                    .kPrimaryColor,
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: const Icon(
                                                          Icons.close,
                                                          size: 15,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )));
                                      }
                                    },
                                  ),
                                ),
                        ]),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();

      return true;
    }

    return false;
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
