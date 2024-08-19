import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_machine/components/build_pagination_control.dart';
import 'package:pos_machine/models/get_store.dart';
import 'package:pos_machine/providers/auth_model.dart';
import 'package:pos_machine/providers/category_providers.dart';
import 'package:pos_machine/providers/purchase_provider.dart';
import 'package:provider/provider.dart';

import '../../components/build_container_box.dart';
import '../../components/build_round_button.dart';
import '../../controllers/sidebar_controller.dart';
import '../../models/get_product.dart';
import '../../providers/grid_provider.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/style_manager.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // Controllers
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController createdByController = TextEditingController();
  final TextEditingController storeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  GetStoreModelData? storeSelected;

  // Variables for selected filters
  String? selectedCategoryId;
  String? selectedProperties;
  String? selectedSupplierId;
  int page = 1;
  bool initLoading = false;

  @override
  void initState() {
    loadInitData();
    super.initState();
  }

  void loadInitData() async {
    try {
      setState(() {
        initLoading = true;
      });
      // String? accessToken =
      //     Provider.of<AuthModel>(context, listen: false).token;

      GridSelectionProvider gridSelectionProvider =
          Provider.of<GridSelectionProvider>(context, listen: false);

      await gridSelectionProvider.listAllProducts(
          // accessToken: accessToken ?? "",
          // page: 1,
          // filterName: productNameController.text,
          );
    } catch (error) {
      debugPrint(error.toString());
    } finally {
      setState(() {
        initLoading = false;
      });
    }
  }

  void searchProducts(page) async {
    debugPrint("SEARCH PRODUCTS CALLED");
    try {
      setState(() {
        initLoading = true;
      });

      GridSelectionProvider gridSelectionProvider =
          Provider.of<GridSelectionProvider>(context, listen: false);

      await gridSelectionProvider.listAllProducts(
        filterName: productNameController.text,
        filterCategory: selectedCategoryId,
        filterPrice: amountController.text,
        filterCreatedBy: createdByController.text,
        filterProperties: selectedProperties,
        filterStore: storeController.text,
        filterSupplier: selectedSupplierId,
        page: page,
      );
    } catch (error) {
      debugPrint(error.toString());
    } finally {
      setState(() {
        initLoading = false;
      });
    }
  }

  void resetSearch() {
    setState(() {
      productNameController.clear();
      storeController.clear();
      amountController.clear();
      selectedCategoryId = null;
      selectedProperties = null;
      selectedSupplierId = null;
      page = 1;
    });
    loadInitData();
  }

  @override
  Widget build(BuildContext context) {
    //  Size size = MediaQuery.of(context).size;
    SideBarController sideBarController = Get.put(SideBarController());
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    GridSelectionProvider gridSelectionProvider =
        Provider.of<GridSelectionProvider>(context);

    Size size = MediaQuery.of(context).size;

    PurchaseProvider purchaseProvider =
        Provider.of<PurchaseProvider>(context, listen: false);
    List<GetStoreModelData>? storeList = purchaseProvider.getStoreList;

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
                      // SizedBox(
                      //   height: 45,
                      //   width: 180, //size.width * 0.5,
                      //   child: TextField(
                      //     cursorColor: ColorManager.kPrimaryColor,
                      //     cursorHeight: 13,
                      //     //  controller: searchTextController,
                      //     onChanged: (query) {
                      //       debugPrint(query);
                      //       final filteredProducts =
                      //           gridSelectionProvider.searchProducts(query);
                      //       gridSelectionProvider
                      //           .updateFilteredProducts(filteredProducts);
                      //     },
                      //     style: buildCustomStyle(FontWeightManager.medium,
                      //         FontSize.s10, 0.18, ColorManager.textColor),
                      //     decoration: decoration.copyWith(
                      //         hintText: "Search    ",
                      //         hintStyle: buildCustomStyle(
                      //             FontWeightManager.medium,
                      //             FontSize.s10,
                      //             0.18,
                      //             ColorManager.textColor),
                      //         // prefixIcon: const Icon(
                      //         //   Icons.search,
                      //         //   color: Colors.black,
                      //         //   size: 35,
                      //         // ),
                      //         prefixIconColor: Colors.black),
                      //   ),
                      // ),
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
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Name",
                              style: buildCustomStyle(
                                FontWeightManager.regular,
                                FontSize.s14,
                                0.27,
                                Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            width: 120,
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  // Update state if needed
                                });
                              },
                              controller: productNameController,
                              cursorColor: ColorManager.kPrimaryColor,
                              cursorHeight: 13,
                              style: buildCustomStyle(
                                FontWeightManager.medium,
                                FontSize.s10,
                                0.18,
                                ColorManager.textColor,
                              ),
                              decoration: decoration.copyWith(
                                hintText: "Product Name",
                                hintStyle: buildCustomStyle(
                                  FontWeightManager.medium,
                                  FontSize.s10,
                                  0.18,
                                  ColorManager.textColor,
                                ),
                                prefixIconColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Filter Category
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Category",
                              style: buildCustomStyle(
                                FontWeightManager.regular,
                                FontSize.s14,
                                0.27,
                                Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            width: 120,
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  // Update state if needed
                                });
                              },
                              cursorColor: ColorManager.kPrimaryColor,
                              cursorHeight: 13,
                              style: buildCustomStyle(
                                FontWeightManager.medium,
                                FontSize.s10,
                                0.18,
                                ColorManager.textColor,
                              ),
                              decoration: decoration.copyWith(
                                hintText: "Category",
                                hintStyle: buildCustomStyle(
                                  FontWeightManager.medium,
                                  FontSize.s10,
                                  0.18,
                                  ColorManager.textColor,
                                ),
                                prefixIconColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Filter Price
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Price",
                              style: buildCustomStyle(
                                FontWeightManager.regular,
                                FontSize.s14,
                                0.27,
                                Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            width: 120,
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  // Update state if needed
                                });
                              },
                              cursorColor: ColorManager.kPrimaryColor,
                              cursorHeight: 13,
                              style: buildCustomStyle(
                                FontWeightManager.medium,
                                FontSize.s10,
                                0.18,
                                ColorManager.textColor,
                              ),
                              controller: amountController,
                              decoration: decoration.copyWith(
                                hintText: "Price",
                                hintStyle: buildCustomStyle(
                                  FontWeightManager.medium,
                                  FontSize.s10,
                                  0.18,
                                  ColorManager.textColor,
                                ),
                                prefixIconColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Filter Properties
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Properties",
                              style: buildCustomStyle(
                                FontWeightManager.regular,
                                FontSize.s14,
                                0.27,
                                Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            width: 120,
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  // Update state if needed
                                });
                              },
                              cursorColor: ColorManager.kPrimaryColor,
                              cursorHeight: 13,
                              style: buildCustomStyle(
                                FontWeightManager.medium,
                                FontSize.s10,
                                0.18,
                                ColorManager.textColor,
                              ),
                              decoration: decoration.copyWith(
                                hintText: "Properties",
                                hintStyle: buildCustomStyle(
                                  FontWeightManager.medium,
                                  FontSize.s10,
                                  0.18,
                                  ColorManager.textColor,
                                ),
                                prefixIconColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Store
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Store",
                              style: buildCustomStyle(
                                FontWeightManager.regular,
                                FontSize.s14,
                                0.27,
                                Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            width: 150,
                            child: BuildBoxShadowContainer(
                              circleRadius: 7,
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 0),
                              padding: const EdgeInsets.only(left: 15),
                              height: size.height * .07,
                              width: size.width / 4.5,
                              child: DropdownButtonFormField<GetStoreModelData>(
                                decoration: const InputDecoration(
                                  border:
                                      InputBorder.none, // Remove the underline
                                ),
                                value: storeSelected,
                                hint: Text(
                                  'Select Store',
                                  style: buildCustomStyle(
                                    FontWeightManager.medium,
                                    FontSize.s12,
                                    0.27,
                                    ColorManager.textColor.withOpacity(.5),
                                  ),
                                ),
                                items:
                                    storeList!.map((GetStoreModelData store) {
                                  return DropdownMenuItem<GetStoreModelData>(
                                      value: store,
                                      child: Text(
                                        store.name ?? '',
                                        style: buildCustomStyle(
                                          FontWeightManager.medium,
                                          FontSize.s12,
                                          0.27,
                                          ColorManager.textColor
                                              .withOpacity(.5),
                                        ),
                                      ));
                                }).toList(),
                                onChanged: (GetStoreModelData? storeModelData) {
                                  if (storeModelData != null) {
                                    // Update the selected category in the provider
                                    setState(() {
                                      storeSelected = storeModelData;
                                      storeController.text =
                                          "${storeModelData.id ?? 1}";
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Filter Supplier
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Supplier",
                              style: buildCustomStyle(
                                FontWeightManager.regular,
                                FontSize.s14,
                                0.27,
                                Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            width: 120,
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  // Update state if needed
                                });
                              },
                              cursorColor: ColorManager.kPrimaryColor,
                              cursorHeight: 13,
                              style: buildCustomStyle(
                                FontWeightManager.medium,
                                FontSize.s10,
                                0.18,
                                ColorManager.textColor,
                              ),
                              decoration: decoration.copyWith(
                                hintText: "Supplier",
                                hintStyle: buildCustomStyle(
                                  FontWeightManager.medium,
                                  FontSize.s10,
                                  0.18,
                                  ColorManager.textColor,
                                ),
                                prefixIconColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 30),
                      child: SizedBox(
                        height: 45,
                        child: CustomRoundButton(
                          title: "Search",
                          fct: () => {searchProducts(1)},
                          height: 45,
                          width: size.width * 0.09,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 30),
                      child: CustomRoundButton(
                        title: "Reset",
                        boxColor: Colors.white,
                        textColor: ColorManager.kPrimaryColor,
                        fct: resetSearch,
                        height: 45,
                        width: size.width * 0.09,
                        fontSize: FontSize.s12,
                      ),
                    ),
                  ],
                ),
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
              PaginationControl(
                currentPage: 1,
                totalPages: 1,
                onPageChanged: (int page) {
                  // searchCategory(page);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
