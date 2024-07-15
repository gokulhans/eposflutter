import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_machine/components/build_dialog_box.dart';

import 'package:provider/provider.dart';

import '../../../../components/build_container_box.dart';
import '../../../../components/build_round_button.dart';
import '../../../../components/build_title.dart';
import '../../../../controllers/sidebar_controller.dart';

import '../../../../models/product_list_file.dart';
import '../../../../providers/auth_model.dart';
import '../../../../providers/grid_provider.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/font_manager.dart';
import '../../../../resources/style_manager.dart';

class AddProductImageOrVideoScreen extends StatefulWidget {
  final Function(int) navigateToScreen;
  const AddProductImageOrVideoScreen(
      {super.key, required this.navigateToScreen});

  @override
  State<AddProductImageOrVideoScreen> createState() =>
      _AddProductImageOrVideoScreenState();
}

class _AddProductImageOrVideoScreenState
    extends State<AddProductImageOrVideoScreen> {
  List<bool> isPrimaryList = [];
  List<TextEditingController> titleControllers = [];
  List<TextEditingController> altControllers = [];
  List<String> filePathList = [];
  List<GetProductListFileModelData>? imageFiles = [];
  int? productId;

  bool isChecked = false;
  final imageTitleController = TextEditingController();
  final imageAltController = TextEditingController();
  int? selectedImageIndex;
  final imageFilePathController = TextEditingController();
  List<Widget> textFields = [];
  List<TextEditingController> controllers = [];
  int count = 1;
  SideBarController sideBarController = Get.put(SideBarController());
  GetProductListFileModelData? selctedImageFile;
  bool initLoading = false;
  List<bool> checkboxValues = [];

  @override
  void initState() {
    super.initState();
    getData();
    addNewImageField();
  }

  @override
  void dispose() {
    for (var controller in titleControllers) {
      controller.dispose();
    }
    for (var controller in altControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void getData() {
    setState(() {
      initLoading = true;
    });

    String? accessToken = Provider.of<AuthModel>(context, listen: false).token;
    productId =
        Provider.of<GridSelectionProvider>(context, listen: false).getProductId;
    Provider.of<GridSelectionProvider>(context, listen: false)
        .getProductListFilesAPI(accessToken: accessToken ?? "")
        .then((value) {
      if (value["status"] == "success") {
        GetProductListFileModel getProductListFileModel =
            GetProductListFileModel.fromJson(value);
        imageFiles = getProductListFileModel.data;
      }
      setState(() {
        initLoading = false;
      });
    });
  }

  void addNewImageField() {
    setState(() {
      isPrimaryList.add(false);
      titleControllers.add(TextEditingController());
      altControllers.add(TextEditingController());
      filePathList.add("");
    });
  }

  void toggleIsPrimary(int index) {
    setState(() {
      for (int i = 0; i < isPrimaryList.length; i++) {
        isPrimaryList[i] = (i == index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    GridSelectionProvider gridSelectionProvider =
        Provider.of<GridSelectionProvider>(context);

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

              child: initLoading
                  ? const CircularProgressIndicator.adaptive()
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(
                            isPrimaryList.length,
                            (index) => buildImageField(index, size),
                          ),
                          const SizedBox(height: 20),
                          // Row(
                          //   children: [
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         BuildTextTile(
                          //           isStarRed: true,
                          //           isTextField: true,
                          //           title: "Title",
                          //           textStyle: buildCustomStyle(
                          //             FontWeightManager.regular,
                          //             FontSize.s14,
                          //             0.27,
                          //             Colors.black.withOpacity(0.6),
                          //           ),
                          //         ),
                          //         BuildBoxShadowContainer(
                          //           circleRadius: 7,
                          //           alignment: Alignment.centerLeft,
                          //           margin: const EdgeInsets.symmetric(
                          //               horizontal: 5, vertical: 0),
                          //           padding: const EdgeInsets.only(left: 15),
                          //           height: size.height * .07,
                          //           width: size.width / 3,
                          //           child: TextFormField(
                          //             keyboardType: TextInputType.text,
                          //             cursorColor: ColorManager.kPrimaryColor,
                          //             decoration: const InputDecoration(
                          //               border: InputBorder.none,
                          //             ),
                          //             controller: imageTitleController,
                          //             style: buildCustomStyle(
                          //               FontWeightManager.medium,
                          //               FontSize.s12,
                          //               0.27,
                          //               ColorManager.textColor.withOpacity(.5),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         BuildTextTile(
                          //           title: "alt",
                          //           isStarRed: true,
                          //           isTextField: true,
                          //           textStyle: buildCustomStyle(
                          //             FontWeightManager.regular,
                          //             FontSize.s14,
                          //             0.27,
                          //             Colors.black.withOpacity(0.6),
                          //           ),
                          //         ),
                          //         BuildBoxShadowContainer(
                          //           circleRadius: 7,
                          //           alignment: Alignment.centerLeft,
                          //           margin: const EdgeInsets.only(left: 20),
                          //           padding: const EdgeInsets.only(left: 15),
                          //           height: size.height * .07,
                          //           width: size.width / 3,
                          //           child: TextFormField(
                          //             keyboardType: TextInputType.text,
                          //             cursorColor: ColorManager.kPrimaryColor,
                          //             decoration: const InputDecoration(
                          //               border: InputBorder.none,
                          //             ),
                          //             controller: imageAltController,
                          //             style: buildCustomStyle(
                          //               FontWeightManager.medium,
                          //               FontSize.s12,
                          //               0.27,
                          //               ColorManager.textColor.withOpacity(.5),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   children: [
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         BuildTextTile(
                          //           isStarRed: true,
                          //           isTextField: true,
                          //           title: "File",
                          //           textStyle: buildCustomStyle(
                          //             FontWeightManager.regular,
                          //             FontSize.s14,
                          //             0.27,
                          //             Colors.black.withOpacity(0.6),
                          //           ),
                          //         ),
                          //         BuildBoxShadowContainer(
                          //           circleRadius: 7,
                          //           alignment: Alignment.centerLeft,
                          //           margin: const EdgeInsets.symmetric(
                          //               horizontal: 5, vertical: 0),
                          //           padding: const EdgeInsets.only(left: 15),
                          //           height: size.height * .07,
                          //           width: size.width / 3,
                          //           child: TextFormField(
                          //             keyboardType: TextInputType.text,
                          //             cursorColor: ColorManager.kPrimaryColor,
                          //             decoration: const InputDecoration(
                          //               border: InputBorder.none,
                          //             ),
                          //             controller: imageFilePathController,
                          //             style: buildCustomStyle(
                          //               FontWeightManager.medium,
                          //               FontSize.s12,
                          //               0.27,
                          //               ColorManager.textColor.withOpacity(.5),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Row(
                          //           children: [
                          //             BuildTextTile(
                          //               isStarRed: true,
                          //               isTextField: true,
                          //               title: "is Primary",
                          //               textStyle: buildCustomStyle(
                          //                 FontWeightManager.regular,
                          //                 FontSize.s14,
                          //                 0.27,
                          //                 Colors.black.withOpacity(0.6),
                          //               ),
                          //             ),
                          //             Checkbox(
                          //               value: isChecked,
                          //               activeColor: ColorManager.kPrimaryColor,
                          //               tristate: true,
                          //               onChanged: (value) {
                          //                 debugPrint(" First onChanged $value");
                          //                 setState(() {
                          //                   isChecked = value ?? false;
                          //                 });
                          //               },
                          //             ),
                          //           ],
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsets.only(left: 20.0),
                          //           child: CustomRoundButton(
                          //             title: "Select Image",
                          //             fct: () async {
                          //               showDialogFunctionForProductDetailsAnimated(
                          //                   context, 0, imageFiles ?? [], size);
                          //             },
                          //             height: 40,
                          //             width: size.width * 0.2,
                          //             fontSize: FontSize.s12,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                          // Column(
                          //   children: textFields,
                          // ),
                          // const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 10.0),
                              //   child: CustomRoundButton(
                              //     title: "Previous",
                              //     fct: () async {},
                              //     height: 50,
                              //     width: size.width * 0.19,
                              //     fontSize: FontSize.s12,
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: CustomRoundButton(
                                  title: "Add More",
                                  boxColor: Colors.white,
                                  textColor: ColorManager.kPrimaryColor,
                                  // fct: () async {
                                  //   debugPrint(
                                  //     "Add More",
                                  //   );
                                  //   TextEditingController titleController =
                                  //       TextEditingController();
                                  //   TextEditingController altController =
                                  //       TextEditingController();
                                  //   TextEditingController fileController =
                                  //       TextEditingController();
                                  //   bool selectedCheckbox = false;

                                  //   controllers.addAll([
                                  //     titleController,
                                  //     altController,
                                  //     fileController,
                                  //   ]);

                                  //   checkboxValues.add(selectedCheckbox);

                                  //   // // Create a new set of text fields
                                  //   // Widget newTextField = buildTextField(titleController, "Title");
                                  //   // Widget newAltField = buildTextField(altController, "Alt");
                                  //   // Widget newFileField = buildTextField(fileController, "File");

                                  //   // Add the new text fields to the list
                                  //   // textFields.addAll([
                                  //   //   newTextField,
                                  //   //   newAltField,
                                  //   //   newFileField
                                  //   // ]);
                                  //   textFields.add(buildTextField(
                                  //       size,
                                  //       titleController,
                                  //       altController,
                                  //       fileController,
                                  //       false
                                  //       //   checkboxValues[count],
                                  //       ));
                                  //   count = count + 1;
                                  //   setState(() {});
                                  // },
                                  fct: addNewImageField,
                                  height: 40,
                                  width: size.width * 0.19,
                                  fontSize: FontSize.s12,
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 10.0),
                              //   child: CustomRoundButton(
                              //     title: "Save",
                              //     fct: () async {},
                              //     height: 40,
                              //     width: size.width * 0.19,
                              //     fontSize: FontSize.s12,
                              //   ),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 15.0, top: 15),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: CustomRoundButton(
                                    title: "Prev",
                                    boxColor: Colors.white,
                                    textColor: ColorManager.kPrimaryColor,
                                    fct: () async {
                                      // sideBarController.index.value = 14;
                                      widget.navigateToScreen(2);
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
                                    // fct: () async {
                                    //   int? productId =
                                    //       gridSelectionProvider.getProductId;
                                    //   if (productId == null) {
                                    //     showScaffold(
                                    //       context: context,
                                    //       message: 'Failed',
                                    //     );
                                    //     // sideBarController.index.value = 14;
                                    //   } else {
                                    //     if (imageAltController.text.isEmpty ||
                                    //         imageFilePathController
                                    //             .text.isEmpty ||
                                    //         imageTitleController.text.isEmpty) {
                                    //       showScaffold(
                                    //         context: context,
                                    //         message:
                                    //             'Please Fill the Required Fields',
                                    //       );
                                    //     } else {
                                    //       showDialog(
                                    //           context: context,
                                    //           barrierDismissible: false,
                                    //           builder: (context) {
                                    //             return const Center(
                                    //               child:
                                    //                   CircularProgressIndicator
                                    //                       .adaptive(),
                                    //             );
                                    //           });
                                    //       String? accessToken =
                                    //           Provider.of<AuthModel>(context,
                                    //                   listen: false)
                                    //               .token;
                                    //       debugPrint(
                                    //           "accessToken From AuthModel $accessToken");
                                    //       gridSelectionProvider
                                    //           .addProductImageAPI(
                                    //               productId: "$productId",
                                    //               title:
                                    //                   imageTitleController.text,
                                    //               alt: imageAltController.text,
                                    //               filePath:
                                    //                   imageFilePathController
                                    //                       .text,
                                    //               isPrimary:
                                    //                   isChecked ? "1" : "0",
                                    //               accessToken:
                                    //                   accessToken ?? "")
                                    //           .then((value) {
                                    //         if (value["status"] == "success") {
                                    //           showScaffold(
                                    //             context: context,
                                    //             message: '${value["message"]}',
                                    //           );
                                    //           sideBarController.index.value =
                                    //               14;
                                    //           gridSelectionProvider
                                    //               .setProductIDForAdding(null);
                                    //           Navigator.pop(context);
                                    //           imageAltController.clear();
                                    //           imageFilePathController.clear();
                                    //           imageTitleController.clear();
                                    //         } else {
                                    //           Navigator.pop(context);

                                    //           showScaffold(
                                    //             context: context,
                                    //             message: '${value["message"]}',
                                    //           );

                                    //           sideBarController.index.value =
                                    //               14;
                                    //         }
                                    //       });
                                    //     }
                                    //   }
                                    // },
                                    fct: () =>
                                        submitImages(gridSelectionProvider),
                                    height: 50,
                                    width: size.width * 0.19,
                                    fontSize: FontSize.s12,
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 10.0),
                                //   child: CustomRoundButton(
                                //     title: "Back",
                                //     boxColor: Colors.white,
                                //     textColor: ColorManager.kPrimaryColor,
                                //     fct: () async {
                                //       sideBarController.index.value = 14;
                                //     },
                                //     height: 50,
                                //     width: size.width * 0.19,
                                //     fontSize: FontSize.s12,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
      Size size,
      TextEditingController titleEditingController,
      TextEditingController altEditingController,
      TextEditingController pathEditingController,
      bool selectedCheckbox) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BuildTextTile(
        title: "Attachment $count",
        textStyle: buildCustomStyle(
          FontWeightManager.regular,
          FontSize.s14,
          0.27,
          Colors.black.withOpacity(0.6),
        ),
      ),
      const Divider(),
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildTextTile(
                isStarRed: true,
                isTextField: true,
                title: "Title",
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
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                padding: const EdgeInsets.only(left: 15),
                height: size.height * .07,
                width: size.width / 3,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: ColorManager.kPrimaryColor,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  controller: titleEditingController,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildTextTile(
                title: "alt",
                isStarRed: true,
                isTextField: true,
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
                margin: const EdgeInsets.only(left: 20),
                padding: const EdgeInsets.only(left: 15),
                height: size.height * .07,
                width: size.width / 3,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: ColorManager.kPrimaryColor,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  controller: altEditingController,
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
        ],
      ),
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildTextTile(
                isStarRed: true,
                isTextField: true,
                title: "File",
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
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                padding: const EdgeInsets.only(left: 15),
                height: size.height * .07,
                width: size.width / 3,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: ColorManager.kPrimaryColor,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  controller: pathEditingController,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BuildTextTile(
                    isStarRed: true,
                    isTextField: true,
                    title: "is Primary",
                    textStyle: buildCustomStyle(
                      FontWeightManager.regular,
                      FontSize.s14,
                      0.27,
                      Colors.black.withOpacity(0.6),
                    ),
                  ),
                  Checkbox(
                    value: selectedCheckbox,
                    activeColor: ColorManager.kPrimaryColor,
                    tristate: true,
                    onChanged: (value) {
                      debugPrint(" Second onChanged $value");
                      setState(() {
                        selectedCheckbox = value ?? false;
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: CustomRoundButton(
                  title: "Select Image",
                  fct: () async {
                    showDialogFunctionForProductDetailsAnimatedAddMore(
                        context,
                        0,
                        titleEditingController,
                        altEditingController,
                        pathEditingController,
                        selectedCheckbox,
                        imageFiles ?? [],
                        size);
                  },
                  height: 40,
                  width: size.width * 0.2,
                  fontSize: FontSize.s12,
                ),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 25),
    ]);
  }

  showDialogFunctionForProductDetailsAnimated(
      BuildContext context,
      int productId,
      final List<GetProductListFileModelData>? attachment,
      Size size) {
    debugPrint("showDialogFunctionForProductDetailsAnimated");
    return showDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "",
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Center(
              child: SizedBox(
                //  padding: const EdgeInsets.all(120.0),
                height: 600,
                width: 700,
                child: Material(
                  type: MaterialType.transparency,
                  child: BuildBoxShadowContainer(
                      circleRadius: 10,
                      padding: const EdgeInsets.all(12),
                      //  height: 380,
                      border: Border.all(
                          color: ColorManager.kPrimaryColor.withOpacity(0.7)),
                      // width: 250, //MediaQuery.of(context).size.width * 0.7,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Select Image",
                                      style: buildCustomStyle(
                                        FontWeightManager.medium,
                                        FontSize.s14,
                                        0.18,
                                        ColorManager.kPrimaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          BuildBoxShadowContainer(
                                            width: 15,
                                            height: 15,
                                            circleRadius: 10,
                                            color: ColorManager.kPrimaryColor,
                                            child: IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(
                                                  Icons.close_rounded,
                                                  size: 10,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                // height: 450,
                                width: 700,
                                child: Table(
                                  columnWidths: const {
                                    0: FractionColumnWidth(0.01),
                                    1: FractionColumnWidth(0.01),
                                    2: FractionColumnWidth(0.1),
                                    3: FractionColumnWidth(0.06),
                                    4: FractionColumnWidth(0.06),
                                    5: FractionColumnWidth(0.05),
                                  },
                                  border: TableBorder.symmetric(
                                      outside: const BorderSide(
                                          color: ColorManager.tableBOrderColor,
                                          width: 0.3),
                                      inside: const BorderSide(
                                          color: ColorManager.tableBOrderColor,
                                          width: 0.8)),
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  children: [
                                    TableRow(
                                        decoration: const BoxDecoration(
                                            color: ColorManager.tableBGColor),
                                        children: [
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Center(
                                                    child: Text(
                                                  "Select",
                                                  style: buildCustomStyle(
                                                    FontWeightManager.medium,
                                                    FontSize.s12,
                                                    0.18,
                                                    ColorManager.kPrimaryColor,
                                                  ),
                                                )),
                                              )),
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Center(
                                                    child: Text(
                                                  "Image Title",
                                                  style: buildCustomStyle(
                                                    FontWeightManager.medium,
                                                    FontSize.s12,
                                                    0.18,
                                                    ColorManager.kPrimaryColor,
                                                  ),
                                                )),
                                              )),
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Center(
                                                    child: Text(
                                                  "Preview",
                                                  style: buildCustomStyle(
                                                    FontWeightManager.medium,
                                                    FontSize.s12,
                                                    0.18,
                                                    ColorManager.kPrimaryColor,
                                                  ),
                                                )),
                                              )),
                                        ]),

                                    // // Map your order data to table rows here
                                    // ...imageFiles!.map((image) {
                                    if (attachment != null)
                                      ...attachment
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        final index = entry.key;
                                        final image = entry.value;
                                        return TableRow(
                                          children: [
                                            TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Center(
                                                    child: Radio<int>(
                                                      value: index,
                                                      groupValue:
                                                          selectedImageIndex,
                                                      onChanged: (int? value) {
                                                        // Set the selected image index
                                                        setState(() {
                                                          selectedImageIndex =
                                                              value ?? 0;
                                                        });

                                                        debugPrint(
                                                            "showDialog $index $selectedImageIndex");
                                                        imageFilePathController
                                                                .text =
                                                            image.id.toString();
                                                        imageAltController
                                                                .text =
                                                            image.alt ?? "";
                                                        imageTitleController
                                                                .text =
                                                            image.title ?? "";
                                                        // Perform any other action if needed
                                                      },
                                                    ),
                                                  ),
                                                )),
                                            TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Center(
                                                    child: Text(
                                                      "${image.title}",
                                                      style: buildCustomStyle(
                                                        FontWeightManager
                                                            .medium,
                                                        FontSize.s9,
                                                        0.13,
                                                        Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                            TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Center(
                                                    child:
                                                        BuildBoxShadowContainer(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 5,
                                                                    right: 5),
                                                            circleRadius: 5,
                                                            child:
                                                                Image.network(
                                                              image.s3Url ?? "",
                                                              fit: BoxFit.cover,
                                                            )),
                                                  ),
                                                )),
                                          ],
                                        );
                                      }).toList(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Row(
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 10.0),
                                    //   child: CustomRoundButton(
                                    //     title: "Create New Image",
                                    //     fct: () async {},
                                    //     height: 50,
                                    //     width: size.width * 0.19,
                                    //     fontSize: FontSize.s12,
                                    //   ),
                                    // ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: CustomRoundButton(
                                        title: "Cancel",
                                        boxColor: Colors.white,
                                        textColor: ColorManager.kPrimaryColor,
                                        fct: () async {
                                          Navigator.pop(context);
                                        },
                                        height: 50,
                                        width: size.width * 0.19,
                                        fontSize: FontSize.s12,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: CustomRoundButton(
                                        title: "Choose",
                                        boxColor: Colors.white,
                                        textColor: ColorManager.kPrimaryColor,
                                        fct: () async {
                                          Navigator.pop(context);
                                        },
                                        height: 50,
                                        width: size.width * 0.19,
                                        fontSize: FontSize.s12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              ),
            );
          });
        });
  }

  showDialogFunctionForProductDetailsAnimatedAddMore(
      BuildContext context,
      int productId,
      TextEditingController titleEditingController,
      TextEditingController altEditingController,
      TextEditingController pathEditingController,
      bool selected,
      final List<GetProductListFileModelData>? attachment,
      Size size) {
    debugPrint("showDialogFunctionForProductDetailsAnimatedAddMore");
    return showDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "",
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Center(
              child: SizedBox(
                //  padding: const EdgeInsets.all(120.0),
                height: 600,
                width: 700,
                child: Material(
                  type: MaterialType.transparency,
                  child: BuildBoxShadowContainer(
                      circleRadius: 10,
                      padding: const EdgeInsets.all(12),
                      //  height: 380,
                      border: Border.all(
                          color: ColorManager.kPrimaryColor.withOpacity(0.7)),
                      // width: 250, //MediaQuery.of(context).size.width * 0.7,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Select Image",
                                      style: buildCustomStyle(
                                        FontWeightManager.medium,
                                        FontSize.s14,
                                        0.18,
                                        ColorManager.kPrimaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          BuildBoxShadowContainer(
                                            width: 15,
                                            height: 15,
                                            circleRadius: 10,
                                            color: ColorManager.kPrimaryColor,
                                            child: IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(
                                                  Icons.close_rounded,
                                                  size: 10,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                //  height: 450,
                                width: 700,
                                child: Table(
                                  columnWidths: const {
                                    0: FractionColumnWidth(0.01),
                                    1: FractionColumnWidth(0.01),
                                    2: FractionColumnWidth(0.1),
                                    3: FractionColumnWidth(0.06),
                                    4: FractionColumnWidth(0.06),
                                    5: FractionColumnWidth(0.05),
                                  },
                                  border: TableBorder.symmetric(
                                      outside: const BorderSide(
                                          color: ColorManager.tableBOrderColor,
                                          width: 0.3),
                                      inside: const BorderSide(
                                          color: ColorManager.tableBOrderColor,
                                          width: 0.8)),
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  children: [
                                    TableRow(
                                        decoration: const BoxDecoration(
                                            color: ColorManager.tableBGColor),
                                        children: [
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Center(
                                                    child: Text(
                                                  "Select",
                                                  style: buildCustomStyle(
                                                    FontWeightManager.medium,
                                                    FontSize.s12,
                                                    0.18,
                                                    ColorManager.kPrimaryColor,
                                                  ),
                                                )),
                                              )),
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Center(
                                                    child: Text(
                                                  "Image Title",
                                                  style: buildCustomStyle(
                                                    FontWeightManager.medium,
                                                    FontSize.s12,
                                                    0.18,
                                                    ColorManager.kPrimaryColor,
                                                  ),
                                                )),
                                              )),
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Center(
                                                    child: Text(
                                                  "Preview",
                                                  style: buildCustomStyle(
                                                    FontWeightManager.medium,
                                                    FontSize.s12,
                                                    0.18,
                                                    ColorManager.kPrimaryColor,
                                                  ),
                                                )),
                                              )),
                                        ]),

                                    // // Map your order data to table rows here
                                    // ...imageFiles!.map((image) {
                                    if (attachment != null)
                                      ...attachment
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        final index = entry.key;
                                        final image = entry.value;
                                        return TableRow(
                                          children: [
                                            TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Center(
                                                    child: Radio<int>(
                                                      value: index,
                                                      groupValue:
                                                          selectedImageIndex,
                                                      onChanged: (int? value) {
                                                        // Set the selected image index
                                                        setState(() {
                                                          selectedImageIndex =
                                                              value ?? 0;
                                                        });

                                                        debugPrint(
                                                            "showDialog $index $selectedImageIndex");
                                                        pathEditingController
                                                            .text = image.id
                                                                .toString() ??
                                                            "";
                                                        altEditingController
                                                                .text =
                                                            image.alt ?? "";
                                                        titleEditingController
                                                                .text =
                                                            image.title ?? "";
                                                        // Perform any other action if needed
                                                      },
                                                    ),
                                                  ),
                                                )),
                                            TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Center(
                                                    child: Text(
                                                      "${image.title}",
                                                      style: buildCustomStyle(
                                                        FontWeightManager
                                                            .medium,
                                                        FontSize.s9,
                                                        0.13,
                                                        Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                            TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Center(
                                                    child:
                                                        BuildBoxShadowContainer(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 5,
                                                                    right: 5),
                                                            circleRadius: 5,
                                                            child:
                                                                Image.network(
                                                              image.s3Url ?? "",
                                                              fit: BoxFit.cover,
                                                            )),
                                                  ),
                                                )),
                                          ],
                                        );
                                      }).toList(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 10.0),
                                    //   child: CustomRoundButton(
                                    //     title: "Create New Image",
                                    //     fct: () async {},
                                    //     height: 50,
                                    //     width: size.width * 0.19,
                                    //     fontSize: FontSize.s12,
                                    //   ),
                                    // ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: CustomRoundButton(
                                        title: "Cancel",
                                        boxColor: Colors.white,
                                        textColor: ColorManager.kPrimaryColor,
                                        fct: () async {
                                          Navigator.pop(context);
                                        },
                                        height: 50,
                                        width: size.width * 0.19,
                                        fontSize: FontSize.s12,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: CustomRoundButton(
                                        title: "Choose",
                                        boxColor: Colors.white,
                                        textColor: ColorManager.kPrimaryColor,
                                        fct: () async {
                                          Navigator.pop(context);
                                        },
                                        height: 50,
                                        width: size.width * 0.19,
                                        fontSize: FontSize.s12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              ),
            );
          });
        });
  }

  Widget buildImageField(int index, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Image ${index + 1}",
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: BuildBoxShadowContainer(
                circleRadius: 7,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: titleControllers[index],
                  decoration: const InputDecoration(
                      labelText: "Title", border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: BuildBoxShadowContainer(
                circleRadius: 7,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: altControllers[index],
                  decoration: const InputDecoration(
                      labelText: "Alt", border: InputBorder.none),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: BuildBoxShadowContainer(
                circleRadius: 7,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(filePathList[index].isEmpty
                    ? "No file selected"
                    : filePathList[index]),
              ),
            ),
            const SizedBox(width: 10),
            CustomRoundButton(
              title: "Select Image",
              fct: () => showImageSelectionDialog(index),
              height: 40,
              width: size.width * 0.2,
              fontSize: FontSize.s12,
            ),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: isPrimaryList[index],
              onChanged: (value) {
                if (value == true) {
                  toggleIsPrimary(index);
                } else {
                  setState(() {
                    isPrimaryList[index] = false;
                  });
                }
              },
            ),
            const Text("Is Primary"),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void showImageSelectionDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select Image"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: imageFiles?.length ?? 0,
            itemBuilder: (context, imageIndex) {
              final image = imageFiles![imageIndex];
              return ListTile(
                title: Text(image.title ?? ""),
                leading:
                    Image.network(image.s3Url ?? "", width: 50, height: 50),
                onTap: () {
                  setState(() {
                    filePathList[index] = image.id.toString();
                    titleControllers[index].text = image.title ?? "";
                    altControllers[index].text = image.alt ?? "";
                  });
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void submitImages(GridSelectionProvider provider) async {
    if (productId == null) {
      showScaffold(context: context, message: 'Product ID is missing');
      return;
    }

    List<String> isPrimary = isPrimaryList.map((e) => e ? "1" : "0").toList();
    List<String> titles = titleControllers.map((e) => e.text).toList();
    List<String> alts = altControllers.map((e) => e.text).toList();

    if (titles.any((title) => title.isEmpty) ||
        alts.any((alt) => alt.isEmpty) ||
        filePathList.any((path) => path.isEmpty)) {
      showScaffold(
          context: context, message: 'Please fill all fields for all images');
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          const Center(child: CircularProgressIndicator.adaptive()),
    );

    String? accessToken = Provider.of<AuthModel>(context, listen: false).token;

    try {
      final result = await provider.addProductImageAPI(
        productId: productId.toString(),
        // isPrimary: isPrimary,
        // titles: titles,
        // alts: alts,
        // filePaths: filePathList,
        accessToken: accessToken ?? "",
      );

      Navigator.of(context).pop(); // Close loading dialog

      if (result["status"] == "success") {
        showScaffold(context: context, message: result["message"]);
        sideBarController.index.value = 14;
        provider.setProductIDForAdding(null);
        clearFields();
      } else {
        showScaffold(context: context, message: result["message"]);
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close loading dialog
      debugPrint("Error: $e");
      showScaffold(
          context: context, message: 'An error occurred. Please try again.');
    }
  }

  void clearFields() {
    setState(() {
      isPrimaryList.clear();
      titleControllers.forEach((controller) => controller.dispose());
      titleControllers.clear();
      altControllers.forEach((controller) => controller.dispose());
      altControllers.clear();
      filePathList.clear();
      addNewImageField(); // Add one empty field
    });
  }
}
