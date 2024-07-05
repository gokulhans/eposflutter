import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_machine/providers/category_providers.dart';
import 'package:pos_machine/resources/asset_manager.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

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
    final categoryProvider = Provider.of<CategoryProvider>(context);
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
                        cursorWidth: 1,
                        //  controller: searchTextController,
                        cursorColor: ColorManager.kPrimaryColor,
                        onChanged: (query) {
                          debugPrint(query);
                          final filteredCategories = categoryProvider
                              .searchCategoryPageCategories(query);

                          categoryProvider.updateCategoryPageFilteredCategories(
                              filteredCategories);
                        },
                        decoration: decoration.copyWith(
                          prefixIcon: WebsafeSvg.asset(
                            ImageAssets.categorySearchIcon,
                            fit: BoxFit.none,
                          ),
                          // suffixIcon: WebsafeSvg.asset(
                          //   ImageAssets.barcodeIcon,
                          //   fit: BoxFit.none,
                          // ),
                          labelStyle: buildCustomStyle(
                              FontWeightManager.regular,
                              FontSize.s10,
                              0.10,
                              ColorManager.textColor),
                          hintText: 'Search category',
                          hintStyle: buildCustomStyle(FontWeightManager.regular,
                              FontSize.s10, 0.13, ColorManager.textColor1),
                        ),
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
                    final List<Category>? categorys =
                        categoryProvider.filteredcategory;

                    debugPrint("filteredcategoryList ${categorys!.length}");

                    // List<Category>? categorys = categoryProvider.category;

                    return Table(
                      columnWidths: const {
                        0: FractionColumnWidth(0.01),
                        1: FractionColumnWidth(0.09),
                        2: FractionColumnWidth(0.09),
                        3: FractionColumnWidth(0.01),
                        // 4: FractionColumnWidth(0.06),
                        // 5: FractionColumnWidth(0.06),
                        // 6: FractionColumnWidth(0.05),
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
                                      "No",
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
                        ...(categorys).asMap().entries.map((entry) {
                          int index = entry.key;
                          Category category = entry.value;
                          return TableRow(
                            children: [
                              TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Center(
                                      child: Text(
                                        "${index + 1}",
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
                                                onPressed: () async {
                                                  await categoryProvider
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
                                                onPressed: () async {
                                                  await categoryProvider
                                                      .setEditCategoryId(
                                                          categoryId: category
                                                                  .categoryId ??
                                                              1);
                                                  await categoryProvider
                                                      .viewCategoryApi(
                                                          categoryId: category
                                                                  .categoryId ??
                                                              1);
                                                  sideBarController
                                                      .index.value = 34;
                                                },
                                              )),
                                          // BuildBoxShadowContainer(
                                          //     margin: const EdgeInsets.only(
                                          //         left: 5, right: 5),
                                          //     circleRadius: 5,
                                          //     color:
                                          //         Colors.red.withOpacity(0.9),
                                          //     child: IconButton(
                                          //       icon: const Icon(
                                          //         Icons.delete,
                                          //         size: 18,
                                          //         color: Colors.white,
                                          //       ),
                                          //       onPressed: () {},
                                          //     )),
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