import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pos_machine/components/build_dialog_box.dart';
import 'package:pos_machine/models/product_list_file.dart';
import 'package:pos_machine/providers/grid_provider.dart';

import 'package:provider/provider.dart';

import '../../components/build_container_box.dart';
import '../../components/build_round_button.dart';
import '../../components/build_text_fields.dart';
import '../../components/build_title.dart';
import '../../controllers/sidebar_controller.dart';
import '../../models/category_list.dart';

import '../../providers/auth_model.dart';
import '../../providers/category_providers.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/style_manager.dart';

class AddCategoryPageScreen extends StatefulWidget {
  const AddCategoryPageScreen({super.key});

  @override
  State<AddCategoryPageScreen> createState() => _AddCategoryPageScreenState();
}

class _AddCategoryPageScreenState extends State<AddCategoryPageScreen> {
  final imageTitleController = TextEditingController();
  final imageAltController = TextEditingController();
  int? selectedImageIndex;
  final imageFilePathController = TextEditingController();
  final iconTitleController = TextEditingController();
  final iconAltController = TextEditingController();
  int? selectedIconIndex;
  final iconFilePathController = TextEditingController();
  List<GetProductListFileModelData>? imageFiles = [];
  GetProductListFileModelData? selctedImageFile;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getData() {
    String? accessToken = Provider.of<AuthModel>(context, listen: false).token;
    Provider.of<GridSelectionProvider>(context, listen: false)
        .getProductListFilesAPI(accessToken: accessToken ?? "")
        .then((value) {
      if (value["status"] == "success") {
        GetProductListFileModel getProductListFileModel =
            GetProductListFileModel.fromJson(value);
        imageFiles = getProductListFileModel.data;
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController categoryNameEnglishController =
        TextEditingController();
    final TextEditingController categoryNameController =
        TextEditingController();
    final TextEditingController categoryNameArabicController =
        TextEditingController();
    final TextEditingController categoryNameHindiController =
        TextEditingController();
    final TextEditingController categorySlugController =
        TextEditingController();
    final TextEditingController idController = TextEditingController(text: "0");
    final TextEditingController categoryIDController =
        TextEditingController(text: "0");
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    SideBarController sideBarController = Get.put(SideBarController());
    Size size = MediaQuery.of(context).size;

    // Access the CategoryProvider
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(
      context,
    );

    // Access the category list
    List<Category>? categoryList = categoryProvider.category;

    void clearText() {
      categoryIDController.clear();
      categoryNameArabicController.clear();
      categoryNameController.clear();
      categoryNameEnglishController.clear();
      categoryNameHindiController.clear();
      categorySlugController.clear();
    }

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
                    'Add New Category',
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
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: size.height * .17,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BuildTextTile(
                                          isStarRed: true,
                                          isTextField: true,
                                          title: "Select Parent Category",
                                          textStyle: buildCustomStyle(
                                            FontWeightManager.regular,
                                            FontSize.s14,
                                            0.27,
                                            Colors.black.withOpacity(0.6),
                                          ),
                                        ),
                                        //**************** For Category Listing ****************
                                        BuildBoxShadowContainer(
                                          circleRadius: 7,
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 0),
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          height: size.height * .07,
                                          width: size.width / 3,
                                          child:
                                              DropdownButtonFormField<Category>(
                                            decoration: const InputDecoration(
                                              border: InputBorder
                                                  .none, // Remove the underline
                                            ),
                                            value: categoryProvider
                                                        .selectedCategoryIndex >=
                                                    0
                                                ? categoryList![categoryProvider
                                                    .selectedCategoryIndex]
                                                : null,
                                            hint: Text(
                                              'Select Category',
                                              style: buildCustomStyle(
                                                FontWeightManager.medium,
                                                FontSize.s12,
                                                0.27,
                                                ColorManager.textColor
                                                    .withOpacity(.5),
                                              ),
                                            ),
                                            items: categoryList!
                                                .map((Category category) {
                                                  return DropdownMenuItem<
                                                          Category>(
                                                      value: category,
                                                      child: category
                                                                  .categoryName ==
                                                              "ALL"
                                                          ? Text(
                                                              ' New Category',
                                                              style:
                                                                  buildCustomStyle(
                                                                FontWeightManager
                                                                    .medium,
                                                                FontSize.s12,
                                                                0.27,
                                                                ColorManager
                                                                    .textColor
                                                                    .withOpacity(
                                                                        .5),
                                                              ),
                                                            )
                                                          : Text(
                                                              category.categoryName ??
                                                                  '',
                                                              style:
                                                                  buildCustomStyle(
                                                                FontWeightManager
                                                                    .medium,
                                                                FontSize.s12,
                                                                0.27,
                                                                ColorManager
                                                                    .textColor
                                                                    .withOpacity(
                                                                        .5),
                                                              ),
                                                            ));
                                                })
                                                .toSet()
                                                .toList(),
                                            onChanged:
                                                (Category? selectedCategory) {
                                              if (selectedCategory != null) {
                                                // Update the selected category in the provider
                                                categoryProvider.selectCategory(
                                                  categoryList.indexOf(
                                                      selectedCategory),
                                                  selectedCategory
                                                          .categoryName ??
                                                      '',
                                                  selectedCategory
                                                          .productsCount ??
                                                      0,
                                                );
                                                debugPrint(
                                                    "onChanged ${selectedCategory.categoryId}");
                                                categoryIDController.text =
                                                    "${selectedCategory.categoryId}";
                                                debugPrint(
                                                    "categoryIdController ${categoryIDController.text}");
                                                categoryProvider.setParentCategory(
                                                    "${selectedCategory.categoryId ?? 0}");
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * .17,
                                    child: buildColumnWidgetForTextFields(
                                      onchanged: (value) {},
                                      isLeft: true,
                                      readOnly: false,
                                      controller: categoryNameEnglishController,
                                      size: size,
                                      title: "Category Name - English (US)*",
                                      hintText: 'Enter...',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  buildColumnWidgetForTextFields(
                                    onchanged: ((value) {
                                      categorySlugController.text = categoryNameController
                                          .text
                                          .toLowerCase() // Convert to lowercase
                                          .replaceAll(RegExp(r'\s+'),
                                              '-') // Replace spaces with hyphens
                                          .replaceAll(RegExp(r'[^a-z0-9-]'),
                                              ''); // Remove non-alphanumeric characters except hyphens
                                    }),
                                    isLeft: false,
                                    readOnly: false,
                                    controller: categoryNameController,
                                    size: size,
                                    title: 'Category Name',
                                    hintText: 'Category Name',
                                  ),
                                  buildColumnWidgetForTextFields(
                                    onchanged: (value) {},
                                    isLeft: true,
                                    readOnly: false,
                                    controller: categoryNameHindiController,
                                    size: size,
                                    title: "Category Name - Hindi(IND)*",
                                    hintText: 'Enter...',
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  buildColumnWidgetForTextFields(
                                      onchanged: (value) {},
                                      isLeft: false,
                                      controller: categorySlugController,
                                      size: size,
                                      title: "Category Slug",
                                      hintText: 'Url Slug',
                                      readOnly: true),
                                  buildColumnWidgetForTextFields(
                                      onchanged: (value) {},
                                      isLeft: true,
                                      controller: categoryNameArabicController,
                                      size: size,
                                      title: "Category Name - Arabic(AR)*",
                                      hintText: 'Enter...',
                                      readOnly: false),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: size.width / 3,
                                        child: BuildTextTile(
                                          title: "Category Image : ",
                                          textStyle: buildCustomStyle(
                                            FontWeightManager.regular,
                                            FontSize.s14,
                                            0.27,
                                            Colors.black.withOpacity(0.6),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: CustomRoundButton(
                                          title: "Select Image",
                                          fct: () async {
                                            showDialogFunctionForCategoryImageDetails(
                                                context,
                                                imageFiles ?? [],
                                                size);
                                          },
                                          height: 40,
                                          width: size.width * 0.1,
                                          fontSize: FontSize.s12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        width: size.width / 3,
                                        child: BuildTextTile(
                                          title: "Category Icon : ",
                                          textStyle: buildCustomStyle(
                                            FontWeightManager.regular,
                                            FontSize.s14,
                                            0.27,
                                            Colors.black.withOpacity(0.6),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: CustomRoundButton(
                                          title: "Select Icon",
                                          fct: () async {
                                            showDialogFunctionForCategoryIconDetails(
                                                context,
                                                imageFiles ?? [],
                                                size);
                                          },
                                          height: 40,
                                          width: size.width * 0.1,
                                          fontSize: FontSize.s12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: CustomRoundButton(
                                      title: "Submit",
                                      fct: () async {
                                        idController.text =
                                            categoryProvider.getParentCategory;
                                        debugPrint(
                                            "categoryIdController.text ${idController.text}");
                                        if (formKey.currentState!.validate()) {
                                          formKey.currentState!.save();
                                          debugPrint("submit");
                                          debugPrint(
                                              "categoryIdController.text ${idController.text}");
                                          debugPrint(
                                              "categoryNameArabicController.text ${categoryNameArabicController.text}");

                                          if (categorySlugController
                                                  .text.isEmpty ||
                                              categoryNameHindiController
                                                  .text.isEmpty ||
                                              categoryNameArabicController
                                                  .text.isEmpty ||
                                              categoryNameEnglishController
                                                  .text.isEmpty ||
                                              categoryNameController
                                                  .text.isEmpty) {
                                            debugPrint(
                                                "isEmptycategorySlugController");
                                            showScaffoldError(
                                              context: context,
                                              message:
                                                  'Please Fill the Required Fields',
                                            );
                                          } else {
                                            debugPrint(
                                                "categoryIdController ${categoryIDController.text}");
                                            showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator
                                                            .adaptive(),
                                                  );
                                                });

                                            String? accessToken =
                                                Provider.of<AuthModel>(context,
                                                        listen: false)
                                                    .token;
                                            debugPrint(
                                                "accessToken From AuthModel $accessToken");
                                            categoryProvider
                                                .addCategory(
                                                    categoryName:
                                                        categoryNameController
                                                            .text,
                                                    slug: categorySlugController
                                                        .text,
                                                    parentCategory:
                                                        idController.text,
                                                    categoryNameEnglish:
                                                        categoryNameEnglishController
                                                            .text,
                                                    categoryNameHindi:
                                                        categoryNameHindiController
                                                            .text,
                                                    categoryNameArabic:
                                                        categoryNameArabicController
                                                            .text,
                                                    imagePath:
                                                        imageFilePathController
                                                            .text,
                                                    iconPath:
                                                        iconFilePathController
                                                            .text,
                                                    accessToken:
                                                        accessToken ?? "")
                                                .then((value) {
                                              if (value["status"] ==
                                                  "success") {
                                                showScaffold(
                                                  context: context,
                                                  message:
                                                      '${value["message"]}',
                                                );

                                                Navigator.pop(context);
                                                clearText();
                                                sideBarController.index.value =
                                                    12;
                                              } else {
                                                debugPrint(
                                                    "errors.password !=null");
                                                Navigator.pop(context);
                                                showScaffold(
                                                  context: context,
                                                  message:
                                                      '${value["message"]}',
                                                );
                                              }
                                            });
                                          }
                                        }
                                      },
                                      height: 50,
                                      width: size.width * 0.19,
                                      fontSize: FontSize.s12,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: CustomRoundButton(
                                      title: "Back",
                                      boxColor: Colors.white,
                                      textColor: ColorManager.kPrimaryColor,
                                      fct: () async {
                                        sideBarController.index.value = 12;
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
                  )
                ],
              ),
            ),
          )),
    );
  }

  showDialogFunctionForCategoryImageDetails(BuildContext context,
      final List<GetProductListFileModelData>? attachment, Size size) {
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

  showDialogFunctionForCategoryIconDetails(BuildContext context,
      final List<GetProductListFileModelData>? attachment, Size size) {
    debugPrint("showDialogFunctionForCategoryIconDetails");
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
                                                          selectedIconIndex,
                                                      onChanged: (int? value) {
                                                        // Set the selected image index
                                                        setState(() {
                                                          selectedIconIndex =
                                                              value ?? 0;
                                                        });

                                                        debugPrint(
                                                            "showDialog $index $selectedIconIndex");
                                                        iconFilePathController
                                                                .text =
                                                            image.id.toString();
                                                        iconAltController.text =
                                                            image.alt ?? "";
                                                        iconTitleController
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
}
