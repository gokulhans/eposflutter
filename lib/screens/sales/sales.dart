import 'package:flutter/material.dart';
import 'package:pos_machine/components/build_container_box.dart';

import '../../resources/color_manager.dart';
import '../../resources/custom_icons.dart';
import '../../resources/font_manager.dart';
import '../../resources/style_manager.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sales',
                      style: buildCustomStyle(FontWeightManager.semiBold,
                          FontSize.s20, 0.30, ColorManager.textColor),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: size.height * 0.04,
                        width: size.width * 0.09,
                        //margin: const EdgeInsets.only(right: 20),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: const [
                            BoxShadow(
                              color: ColorManager.boxShadowColor,
                              blurRadius: 6,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: 0),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {},
                                icon: const Icon(
                                  CustomIcons.iconFilterList,
                                  color: Colors.black,
                                  size: 10,
                                )),
                            Text(
                              "Filters",
                              style: buildCustomStyle(
                                FontWeightManager.semiBold,
                                FontSize.s12,
                                0.27,
                                Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                BuildBoxShadowContainer(
                  circleRadius: 7,
                  offsetValue: const Offset(1, 1),
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
                        outside: BorderSide.none,
                        inside: const BorderSide(
                            color: ColorManager.tableBOrderColor, width: 0.8)),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
                                    "Order ID",
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
                                    "Date",
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
                                    "Order Summary",
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
                                    "Offers Applied",
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
                                    "Payment summary",
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
                                    "Customer Details",
                                    style: buildCustomStyle(
                                      FontWeightManager.medium,
                                      FontSize.s12,
                                      0.18,
                                      ColorManager.kPrimaryColor,
                                    ),
                                  )),
                                )),
                          ]),
                      ...List.generate(
                        6,
                        (index) => TableRow(
                          children: [
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Center(
                                    child: Text(
                                      "#34566",
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
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Text(
                                      "25/06/2022",
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
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Text(
                                      " 1 MIGHTY ZINGER BOX 150 g\n2 MIGHTY ZINGER BOX 150 g\n3 MIGHTY ZINGER BOX 150 g",
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
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Text(
                                      "20% offer applied\n20% offer applied\n20% offer applied",
                                      style: buildCustomStyle(
                                        FontWeightManager.medium,
                                        FontSize.s9,
                                        0.13,
                                        ColorManager.kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                )),
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Text(
                                      "\$115.00",
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
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Text(
                                      "Iris Watson\n +91 6845567860",
                                      style: buildCustomStyle(
                                        FontWeightManager.medium,
                                        FontSize.s9,
                                        0.13,
                                        Colors.black,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
