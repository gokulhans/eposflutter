import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_machine/providers/category_providers.dart';
import 'package:provider/provider.dart';

import '../../components/build_container_box.dart';
import '../../components/build_round_button.dart';
import '../../controllers/sidebar_controller.dart';
import '../../models/get_product.dart';
import '../../providers/grid_provider.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/style_manager.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //  Size size = MediaQuery.of(context).size;
    SideBarController sideBarController = Get.put(SideBarController());
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(
      context,
    );
    GridSelectionProvider gridSelectionProvider =
        Provider.of<GridSelectionProvider>(context);

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
                    "Product List  ",
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
                          cursorColor: ColorManager.kPrimaryColor,
                          cursorHeight: 13,
                          //  controller: searchTextController,
                          onChanged: (query) {
                            debugPrint(query);
                            final filteredProducts =
                                gridSelectionProvider.searchProducts(query);
                            gridSelectionProvider
                                .updateFilteredProducts(filteredProducts);
                          },
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
                        title: "Create New Product",
                        fct: () {
                          sideBarController.index.value = 17;
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
                  margin: const EdgeInsets.only(top: 20),
                  circleRadius: 7,
                  offsetValue: const Offset(1, 1),
                  child: Consumer<GridSelectionProvider>(
                    builder: (context, productProvider, child) {
                      List<GetProduct>? productList =
                          productProvider.productList;

                      return Table(
                        columnWidths: const {
                          0: FractionColumnWidth(0.01),
                          1: FractionColumnWidth(0.03),
                          2: FractionColumnWidth(0.03),
                          3: FractionColumnWidth(0.03),
                          4: FractionColumnWidth(0.03),
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
                                        "Product Name",
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
                          ...productList!.asMap().entries.map((entry) {
                            int index = entry.key; // This is the index
                            var products = entry.value; // This is the product
                            // Assuming each product has a list of categories and you want the name of the first category
                            String categoryName = products.category != null &&
                                    products.category!.isNotEmpty
                                ? products.category!.first.name ?? 'Unknown'
                                : 'No Category';
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
                                          "${products.productName}",
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
                                          "$categoryName",
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
                                          "${products.productSlug}",
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
                                                    productProvider
                                                        .callProductDetails(
                                                            products.productId ??
                                                                1);
                                                    sideBarController
                                                        .index.value = 28;
                                                  },
                                                )),
                                            BuildBoxShadowContainer(
                                                margin: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                color: ColorManager
                                                    .kPrimaryColor
                                                    .withOpacity(0.9),
                                                circleRadius: 5,
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    size: 18,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () async {
                                                    Provider.of<CategoryProvider>(
                                                            context,
                                                            listen: false)
                                                        .resetPropValues();
                                                    gridSelectionProvider
                                                        .setProductIDForAdding(
                                                            products.productId);
                                                    await categoryProvider
                                                        .setCategoryIdforProp(
                                                            categoryId: products
                                                                    .categoryId ??
                                                                1);
                                                    productProvider
                                                        .callProductDetails(
                                                            products
                                                                .productId!);
                                                    sideBarController
                                                        .index.value = 35;
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
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
