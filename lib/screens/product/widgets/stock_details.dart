import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_machine/models/list_stock.dart';

import 'package:provider/provider.dart';

import '../../../components/build_container_box.dart';
import '../../../components/build_round_button.dart';
import '../../../controllers/sidebar_controller.dart';

import '../../../providers/grid_provider.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/style_manager.dart';

class StockDetailsWidget extends StatelessWidget {
  const StockDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SideBarController sideBarController = Get.put(SideBarController());
    GridSelectionProvider gridSelectionProvider =
        Provider.of<GridSelectionProvider>(context);

    ListStockModelData? stockDetails =
        gridSelectionProvider.getViewStockModelData;

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
                  " Stock Details  ",
                  style: buildCustomStyle(FontWeightManager.semiBold,
                      FontSize.s20, 0.30, ColorManager.textColor),
                ),
                BuildBoxShadowContainer(
                  width: 15,
                  height: 15,
                  circleRadius: 10,
                  color: ColorManager.kPrimaryColor,
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        sideBarController.index.value = 15;
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 10,
                        color: Colors.white,
                      )),
                )
              ],
            ),
            Container(
              height: 60,
              decoration: const BoxDecoration(
                color: ColorManager.kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
              ),
              padding: const EdgeInsets.only(
                left: 20,
                top: 20,
              ),
              margin: const EdgeInsets.only(
                  top: 20, bottom: 0, left: 10, right: 10),
              child: Text(
                " Show Stock",
                style: buildCustomStyle(FontWeightManager.semiBold,
                    FontSize.s15, 0.30, Colors.white),
              ),
            ),
            BuildBoxShadowContainer(
                height: size.height, //120,
                margin: const EdgeInsets.only(
                    top: 0, bottom: 10, left: 10, right: 10),
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                circleRadius: 7,
                offsetValue: const Offset(1, 1),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 8.0, top: 10),
                        child: Text(
                          "Product Primary Details",
                          style: buildCustomStyle(FontWeightManager.semiBold,
                              FontSize.s18, 0.30, ColorManager.textColor),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, top: 10),
                            child: SizedBox(
                              width: size.width / 3,
                              child: Text(
                                softWrap: true,
                                maxLines: 2,
                                "Product Name : ${stockDetails == null ? "" : stockDetails.productName}",
                                style: buildCustomStyle(
                                    FontWeightManager.semiBold,
                                    FontSize.s15,
                                    0.30,
                                    ColorManager.textColor),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, top: 10),
                            child: SizedBox(
                              width: size.width / 3,
                              child: Text(
                                softWrap: true,
                                maxLines: 2,
                                " Product Slug : ${stockDetails == null ? "" : stockDetails.product!.slug}",
                                style: buildCustomStyle(
                                    FontWeightManager.semiBold,
                                    FontSize.s15,
                                    0.30,
                                    ColorManager.textColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, top: 10),
                            child: SizedBox(
                              width: size.width / 3,
                              child: Text(
                                softWrap: true,
                                maxLines: 2,
                                " Product Price : ${stockDetails == null ? "" : stockDetails.product!.price ?? ""} ",
                                style: buildCustomStyle(
                                    FontWeightManager.semiBold,
                                    FontSize.s15,
                                    0.30,
                                    ColorManager.textColor),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, top: 10),
                            child: SizedBox(
                              width: size.width / 3,
                              child: Text(
                                softWrap: true,
                                maxLines: 2,
                                " Product Available Stock : ${stockDetails == null ? "" : stockDetails.quantity} ",
                                style: buildCustomStyle(
                                    FontWeightManager.semiBold,
                                    FontSize.s15,
                                    0.30,
                                    ColorManager.textColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 8.0, top: 10),
                        child: Text(
                          " Sell Currency : ${stockDetails == null ? "" : stockDetails.product!.currency ?? ""}",
                          style: buildCustomStyle(FontWeightManager.semiBold,
                              FontSize.s15, 0.30, ColorManager.textColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 8.0, top: 10),
                        child: Text(
                          "Product Stock Details",
                          style: buildCustomStyle(FontWeightManager.semiBold,
                              FontSize.s18, 0.30, ColorManager.textColor),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, top: 10),
                            child: SizedBox(
                              width: size.width / 3,
                              child: Text(
                                softWrap: true,
                                maxLines: 2,
                                " Store Name : ${stockDetails == null ? "" : stockDetails.storeName}",
                                style: buildCustomStyle(
                                    FontWeightManager.semiBold,
                                    FontSize.s15,
                                    0.30,
                                    ColorManager.textColor),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, top: 10),
                            child: SizedBox(
                              width: size.width / 3,
                              child: Text(
                                softWrap: true,
                                maxLines: 2,
                                " Product Quantity : ${stockDetails == null ? "" : stockDetails.quantity}",
                                style: buildCustomStyle(
                                    FontWeightManager.semiBold,
                                    FontSize.s15,
                                    0.30,
                                    ColorManager.textColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, top: 10),
                            child: SizedBox(
                              width: size.width / 3,
                              child: Text(
                                softWrap: true,
                                maxLines: 2,
                                " Product Unit : ${stockDetails == null ? "" : stockDetails.unit}",
                                style: buildCustomStyle(
                                    FontWeightManager.semiBold,
                                    FontSize.s15,
                                    0.30,
                                    ColorManager.textColor),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, top: 10),
                            child: SizedBox(
                              width: size.width / 3,
                              child: Text(
                                softWrap: true,
                                maxLines: 2,
                                " Purchase Rate : ${stockDetails == null ? "" : stockDetails.purchaseRate}",
                                style: buildCustomStyle(
                                    FontWeightManager.semiBold,
                                    FontSize.s15,
                                    0.30,
                                    ColorManager.textColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, top: 10),
                            child: SizedBox(
                              width: size.width / 3,
                              child: Text(
                                softWrap: true,
                                maxLines: 2,
                                " Retail Price : ${stockDetails == null ? "" : stockDetails.retailPrice}",
                                style: buildCustomStyle(
                                    FontWeightManager.semiBold,
                                    FontSize.s15,
                                    0.30,
                                    ColorManager.textColor),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, top: 10),
                            child: SizedBox(
                              width: size.width / 3,
                              child: Text(
                                softWrap: true,
                                maxLines: 2,
                                " Wholesale Price : ${stockDetails == null ? "" : stockDetails.wholesalePrice}",
                                style: buildCustomStyle(
                                    FontWeightManager.semiBold,
                                    FontSize.s15,
                                    0.30,
                                    ColorManager.textColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, top: 10),
                            child: SizedBox(
                              width: size.width / 3,
                              child: Text(
                                softWrap: true,
                                maxLines: 2,
                                " Wholesale Min Unit : ${stockDetails == null ? "" : stockDetails.wholesaleMinUnit}",
                                style: buildCustomStyle(
                                    FontWeightManager.semiBold,
                                    FontSize.s15,
                                    0.30,
                                    ColorManager.textColor),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, top: 10),
                            child: SizedBox(
                              width: size.width / 3,
                              child: Text(
                                softWrap: true,
                                maxLines: 2,
                                " Expiry Date : ${stockDetails == null ? "" : stockDetails.expiryDate}",
                                style: buildCustomStyle(
                                    FontWeightManager.semiBold,
                                    FontSize.s15,
                                    0.30,
                                    ColorManager.textColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 8.0, top: 10),
                        child: Text(
                          " Batch Number : ${stockDetails == null ? "" : stockDetails.batchNumber}",
                          style: buildCustomStyle(FontWeightManager.semiBold,
                              FontSize.s15, 0.30, ColorManager.textColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 8.0, top: 10),
                        child: Text(
                          "Product Properties",
                          style: buildCustomStyle(FontWeightManager.semiBold,
                              FontSize.s18, 0.30, ColorManager.textColor),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CustomRoundButton(
                          title: "Back",
                          boxColor: Colors.white,
                          textColor: ColorManager.kPrimaryColor,
                          fct: () async {
                            sideBarController.index.value = 15;
                          },
                          height: 50,
                          width: size.width * 0.19,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
