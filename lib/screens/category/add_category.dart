import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_machine/providers/category_providers.dart';
import 'package:provider/provider.dart';

import '../../components/build_container_box.dart';
import '../../components/build_round_button.dart';
import '../../controllers/sidebar_controller.dart';
import '../../models/category_list.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/style_manager.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SideBarController sideBarController = Get.put(SideBarController());
    final searchTextController = TextEditingController();

    return SafeArea(
        child: Container(
      margin: const EdgeInsets.only(left: 10, top: 20, bottom: 0, right: 10),
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
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Category  ",
                  style: buildCustomStyle(FontWeightManager.semiBold,
                      FontSize.s20, 0.30, ColorManager.textColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 180, //size.width * 0.5,
                      child: TextField(
                        onChanged: (value) {
                          //  filterCategories(value, categoryProvider.categoryList);
                        },
                        cursorColor: ColorManager.kPrimaryColor,
                        cursorHeight: 13,
                        controller: searchTextController,
                        style: buildCustomStyle(FontWeightManager.medium,
                            FontSize.s10, 0.18, ColorManager.textColor),
                        decoration: decoration.copyWith(
                            hintText: "Search    ",
                            hintStyle: buildCustomStyle(
                                FontWeightManager.medium,
                                FontSize.s10,
                                0.18,
                                ColorManager.textColor),
                            // prefixIcon: const Icon(
                            //   Icons.search,
                            //   color: Colors.black,
                            //   size: 35,
                            // ),
                            prefixIconColor: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomRoundButton(
                      title: "Create New Category",
                      fct: () {
                        sideBarController.index.value = 16;
                      },
                      fontSize: 12,
                      height: 45,
                      width: 200,
                    ),
                  ],
                ),
              ],
            ),
            BuildBoxShadowContainer(
                // height: size.height, //120,
                margin: const EdgeInsets.only(top: 20, bottom: 0),
                circleRadius: 7,
                offsetValue: const Offset(1, 1),
                child: Consumer<CategoryProvider>(
                  builder: (context, categoryProvider, child) {
                    final List<Category>? categorys = categoryProvider.category;

                    // List<Category>? categorys = categoryProvider.category;

                    return Table(
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
                              color: ColorManager.tableBOrderColor, width: 0.3),
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
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Center(
                                        child: Text(
                                      "Category Name",
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
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Center(
                                        child: Text(
                                      "Slug",
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
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Center(
                                        child: Text(
                                      "Action",
                                      style: buildCustomStyle(
                                        FontWeightManager.medium,
                                        FontSize.s12,
                                        0.18,
                                        ColorManager.kPrimaryColor,
                                      ),
                                    )),
                                  )),
                            ]),

                        // Map your order data to table rows here
                        ...(categorys!).skip(1).map((category) {
                          return TableRow(
                            children: [
                              TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Center(
                                      child: Text(
                                        "${category.categoryName}",
                                        style: buildCustomStyle(
                                          FontWeightManager.medium,
                                          FontSize.s9,
                                          0.13,
                                          Colors.black,
                                        ),
                                      ),
                                    ),
                                  )),
                              TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Center(
                                      child: Text(
                                        "${category.categorySlug}",
                                        style: buildCustomStyle(
                                          FontWeightManager.medium,
                                          FontSize.s9,
                                          0.13,
                                          Colors.black,
                                        ),
                                      ),
                                    ),
                                  )),
                              TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          BuildBoxShadowContainer(
                                              margin: const EdgeInsets.only(
                                                  left: 5, right: 5),
                                              circleRadius: 5,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.visibility,
                                                  size: 18,
                                                  color: ColorManager
                                                      .kPrimaryColor
                                                      .withOpacity(0.9),
                                                ),
                                                onPressed: () {
                                                  categoryProvider
                                                      .viewCategoryApi(
                                                          categoryId: category
                                                                  .categoryId ??
                                                              1);
                                                  sideBarController
                                                      .index.value = 27;
                                                },
                                              )),
                                          BuildBoxShadowContainer(
                                              margin: const EdgeInsets.only(
                                                  left: 5, right: 5),
                                              color: ColorManager.kPrimaryColor
                                                  .withOpacity(0.9),
                                              circleRadius: 5,
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.edit,
                                                  size: 18,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {},
                                              )),
                                          BuildBoxShadowContainer(
                                              margin: const EdgeInsets.only(
                                                  left: 5, right: 5),
                                              circleRadius: 5,
                                              color:
                                                  Colors.red.withOpacity(0.9),
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  size: 18,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  
                                                },
                                              )),
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          );
                        }).toList(),
                      ],
                    );
                  },
                ))
          ],
        ),
      ),
    ));
  }
}
// ...categorys!.asMap().entries.map((entry) {
//   final int index = entry.key;
//   final Category category = entry.value;