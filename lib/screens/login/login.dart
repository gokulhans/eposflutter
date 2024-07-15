import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_machine/components/build_dialog_box.dart';
import 'package:pos_machine/components/main_screen.dart';
import 'package:pos_machine/models/executive.dart';
import 'package:pos_machine/providers/authentication_providers.dart';
import 'package:pos_machine/providers/sales_provider.dart';
import 'package:pos_machine/providers/shared_preferences.dart';
import 'package:pos_machine/screens/login/forgot_password.dart';
import 'package:provider/provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/build_round_button.dart';
import '../../components/build_title.dart';
import '../../providers/auth_model.dart';

import '../../providers/invoice_provider.dart';
import '../../providers/purchase_provider.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/style_manager.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _rememberMe = false;
  final _emailController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _loadUserEmailPassword();
  }

  void _loadUserEmailPassword() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var prefsEmail = prefs.getString("emailRemember") ?? "";
      var prefsPassword = prefs.getString("passwordRemember") ?? "";
      var prefsRememberMe = prefs.getBool("remember_me") ?? false;

      if (prefsRememberMe) {
        setState(() {
          _rememberMe = true;
        });
        _emailController.text = prefsEmail;
        _passwordTextController.text = prefsPassword;
      }
    } catch (e) {
      rethrow;
    }
  }

  void _handleRemeberme(bool value) {
    _rememberMe = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('emailRemember', _emailController.text);
        prefs.setString('passwordRemember', _passwordTextController.text);
      },
    );
    setState(() {
      _rememberMe = value;
    });
  }

  @override
  void dispose() {
    _emailController.clear();
    _passwordTextController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    final authModel = Provider.of<AuthModel>(context);
    return Scaffold(
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
                    title: 'Login',
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
                          SizedBox(
                            width: size.width / 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: validateEmail,
                                key: const Key("Phone_Number_Sign_in"),
                                cursorColor: ColorManager.kPrimaryColor,
                                controller: _emailController,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9@a-zA-Z.]")),
                                ],
                                keyboardType: TextInputType.emailAddress,
                                decoration: decoration.copyWith(
                                  prefixIcon: Icon(
                                    Icons.email_rounded,
                                    color: ColorManager.kPrimaryColor
                                        .withOpacity(0.5),
                                  ),
                                  hintText: '*****@domain.com',
                                  hintStyle: buildTextFieldStyle,
                                ),
                              ),
                            ),
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

                                // validator: (value) {
                                //   RegExp regex = RegExp(
                                //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                //   if (value!.isEmpty) {
                                //     return 'Please enter password here';
                                //   } else {
                                //     if (!regex.hasMatch(value)) {
                                //       return 'Enter valid password';
                                //     } else {
                                //       return null;
                                //     }
                                //   }
                                // },
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
                              padding: const EdgeInsets.all(30.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _rememberMe = !_rememberMe;
                                            _handleRemeberme(_rememberMe);
                                          });
                                        },
                                        child: Container(
                                          height: height * 0.02,
                                          width: width * 0.02,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: _rememberMe
                                                ? null
                                                : Border.all(
                                                    color: ColorManager.grey,
                                                    width: 2.0),
                                            color: _rememberMe
                                                ? ColorManager.kPrimaryColor
                                                : Colors.white,
                                            // borderRadius:
                                            //     BorderRadius.circular(30),
                                          ),
                                          child: _rememberMe
                                              ? const Icon(
                                                  Icons.check,
                                                  size: 10,
                                                  color: Colors.white,
                                                )
                                              : null,
                                        ),
                                      ),
                                      const Text(
                                        'Remember Me',
                                        style: TextStyle(
                                          fontWeight: FontWeightManager.regular,
                                          fontFamily: FontConstants.fontFamily,
                                          fontSize: FontSize.s8,
                                          letterSpacing: 0.12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ForgotPasswordScreen()));
                                    },
                                    child: const Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        fontWeight: FontWeightManager.medium,
                                        fontFamily: FontConstants.fontFamily,
                                        fontSize: FontSize.s10,
                                        letterSpacing: 0.16,
                                        color: ColorManager.kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ],
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
                                    title: 'Continue',
                                    fct: () async {
                                      // await Future.delayed(
                                      //         const Duration(seconds: 1))
                                      //     .then((value) => Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 const MainScreen())));
                                      if (_emailController.text.isNotEmpty ||
                                          _passwordTextController
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
                                        await AuthenticationProvider()
                                            .login(
                                                _emailController.text,
                                                _passwordTextController.text,
                                                context)
                                            .then((value) async {
                                          // Navigator.pop(context);
                                          if (value["status"] == "success") {
                                            ExecutiveModel executiveModel =
                                                ExecutiveModel.fromJson(value);
                                            ExecutiveModelData?
                                                executiveModelData =
                                                executiveModel.data;

                                            authModel.login(
                                                executiveModelData
                                                        ?.accessToken ??
                                                    "",
                                                executiveModelData?.userId ??
                                                    0);
                                            SharedPreferenceProvider()
                                                .saveAccessTokenandCustomerId(
                                                    executiveModelData
                                                            ?.accessToken ??
                                                        "",
                                                    executiveModelData
                                                            ?.userId ??
                                                        0,
                                                    executiveModelData
                                                            ?.userName ??
                                                        "");
                                            SalesProvider salesProvider =
                                                Provider.of<SalesProvider>(
                                                    context,
                                                    listen: false);
                                            salesProvider.setUserId(
                                              executiveModelData?.userId ?? 0,
                                            );
                                            debugPrint(
                                                " authmodel token ${authModel.token}");
                                            debugPrint(
                                                " authmodel token ${authModel.token}");
                                            InvoiceProvider invoiceProvider =
                                                Provider.of<InvoiceProvider>(
                                                    context,
                                                    listen: false);
                                            PurchaseProvider purchaseProvider =
                                                Provider.of<PurchaseProvider>(
                                                    context,
                                                    listen: false);
                                            invoiceProvider
                                                .listAllInvoiceAccountTypes(
                                                    authModel.token ?? '');
                                            invoiceProvider.listAllPaymentList(
                                                authModel.token ?? '');
                                            invoiceProvider
                                                .listVoucherAccountType(
                                                    authModel.token ?? '');
                                            invoiceProvider.listUsersList(
                                                authModel.token ?? '');
                                            purchaseProvider.listAllStores(
                                                authModel.token ?? '', null);
                                            purchaseProvider.listAllSuppliers(
                                                authModel.token ?? '', null);
                                            purchaseProvider.listAllUnits(
                                                authModel.token ?? '');

                                            showScaffold(
                                              context: context,
                                              message: '${value["message"]}',
                                            );
                                            Navigator.pop(context);

                                            await Future.delayed(
                                                    const Duration(seconds: 1))
                                                .then((value) => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MainScreen())));
                                          } else {
                                            Navigator.pop(context);
                                            showScaffoldError(
                                              context: context,
                                              message: '${value["message"]}',
                                            );
                                          }
                                        });
                                      } else {
                                        showScaffoldError(
                                            context: context,
                                            message: 'Please Fill Details!');
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
