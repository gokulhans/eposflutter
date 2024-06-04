import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pos_machine/components/build_dialog_box.dart';

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

class EditCategoryPageScreen extends StatelessWidget {
  const EditCategoryPageScreen({super.key});

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

    // categoryList![0] = Category(
    //   categoryId: 0,
    //   categorySlug: "NEW_CATEGORY",
    //   categoryName: "Select New Category",
    //   productsCount: 0,
    // );
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
                    'Edit Category',
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
                                      categorySlugController.text =
                                          categoryNameController.text
                                              .toLowerCase();
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
                                            showScaffold(
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
                                                .editCategory(
                                              categoryId: 1,
                                              categoryName:
                                                  categoryNameController.text,
                                              slug: categorySlugController.text,
                                              parentCategory: idController.text,
                                              categoryNameEnglish:
                                                  categoryNameEnglishController
                                                      .text,
                                              categoryNameHindi:
                                                  categoryNameHindiController
                                                      .text,
                                              categoryNameArabic:
                                                  categoryNameArabicController
                                                      .text,
                                              accessToken: accessToken ?? "",
                                            )
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
}
