import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos_machine/components/build_container_box.dart';
import 'package:pos_machine/helpers/amount_helper.dart';
import 'package:pos_machine/helpers/date_helper.dart';
import 'package:pos_machine/models/add_to_cart.dart';
import 'package:pos_machine/models/get_store.dart';
import 'package:pos_machine/providers/purchase_provider.dart';
import 'package:pos_machine/providers/sales_provider.dart';
import 'package:provider/provider.dart';

import '../../components/build_round_button.dart';
import '../../controllers/sidebar_controller.dart';
import '../../models/list_sales_order.dart';
import '../../providers/auth_model.dart';
import '../../resources/color_manager.dart';

import '../../resources/font_manager.dart';
import '../../resources/style_manager.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  Widget build(BuildContext context) {
    SideBarController sideBarController = Get.put(SideBarController());
    final searchTextController = TextEditingController();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d,MMMM,y').format(now);
    final dateController =
        TextEditingController(text: formattedDate); //"6,April,2023");
    final dateFormatController = TextEditingController();
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
                Text(
                  "Orders List",
                  style: buildCustomStyle(FontWeightManager.semiBold,
                      FontSize.s20, 0.30, ColorManager.textColor),
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
                                "Number",
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
                                  hintText: "Number",
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

                      // Name
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
                                cursorColor: ColorManager.kPrimaryColor,
                                cursorHeight: 13,
                                style: buildCustomStyle(
                                  FontWeightManager.medium,
                                  FontSize.s10,
                                  0.18,
                                  ColorManager.textColor,
                                ),
                                decoration: decoration.copyWith(
                                  hintText: "Name",
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

                      // Date
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Date",
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
                                  hintText: "Date",
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

                      // Status
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Status",
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
                                  hintText: "Status",
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

                      // Price
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

                      // Email
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Email",
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
                                  hintText: "Email",
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

                      // Phone
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Phone",
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
                                  hintText: "Phone",
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
                                  hintText: "Store",
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

                      // Created By
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Created By",
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
                                  hintText: "Created By",
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
                        child: CustomRoundButton(
                          title: "Search",
                          fct: (searchAccountBook) {},
                          height: 45,
                          width: size.width * 0.09,
                          fontSize: FontSize.s12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 30),
                        child: CustomRoundButton(
                          title: "Reset",
                          boxColor: Colors.white,
                          textColor: ColorManager.kPrimaryColor,
                          fct: (resetSearch) {},
                          height: 45,
                          width: size.width * 0.09,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text(
                    //   'Sales',
                    //   style: buildCustomStyle(FontWeightManager.semiBold,
                    //       FontSize.s20, 0.30, ColorManager.textColor),
                    // ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 45,
                          width: 150, //size.width * 0.5,
                          child: TextField(
                            cursorColor: ColorManager.kPrimaryColor,
                            cursorHeight: 13,
                            controller: searchTextController,
                            style: buildCustomStyle(FontWeightManager.medium,
                                FontSize.s10, 0.18, ColorManager.textColor),
                            decoration: decoration.copyWith(
                                hintText: "Search Order",
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
                        BuildBoxShadowContainer(
                          margin: const EdgeInsets.all(15),
                          // padding: const EdgeInsets.all(15),
                          height: 45,
                          width: 190,
                          circleRadius: 4,
                          child: GestureDetector(
                            onTap: () async {
                              DateTime? datePicked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2021),
                                  lastDate: DateTime(2025));
                              if (datePicked != null) {
                                String dateFormat = DateFormat(
                                        DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY)
                                    .format(datePicked);
                                debugPrint(
                                    "date Picked ${datePicked.day},${datePicked.month},${datePicked.year}");
                                debugPrint(dateFormat);
                                String formattedDate = DateFormat('d,MMMM,yyyy')
                                    .format(datePicked);
                                debugPrint(formattedDate);
                                dateController.text = formattedDate;
                                dateFormatController.text =
                                    DateFormat('yyyy-MM-dd').format(datePicked);
                                searchTextController.clear();
                              }
                            },
                            child: TextField(
                              cursorColor: ColorManager.kPrimaryColor,
                              cursorHeight: 20,
                              controller: dateController,
                              enabled: false,
                              style: buildCustomStyle(FontWeightManager.medium,
                                  FontSize.s10, 0.18, ColorManager.textColor),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  // labelText: dateController.text,
                                  labelStyle: buildCustomStyle(
                                      FontWeightManager.medium,
                                      FontSize.s10,
                                      0.18,
                                      ColorManager.textColor),
                                  hintText: dateController.text,
                                  //  hintText: "6,April,2022",
                                  hintStyle: buildCustomStyle(
                                      FontWeightManager.medium,
                                      FontSize.s10,
                                      0.18,
                                      ColorManager.textColor),
                                  prefixIcon: const Icon(
                                    Icons.calendar_month,
                                    size: 12,
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 12,
                                  ),
                                  prefixIconColor: Colors.black),
                            ),
                          ),

                          //  Row(
                          //   children: [
                          //     const Icon(
                          //       Icons.calendar_month,
                          //       size: 10,
                          //     ),
                          //     const SizedBox(width: 6),
                          //     Text(
                          //       "6,April,2022",
                          //       style: buildCustomStyle(
                          //           FontWeightManager.medium,
                          //           FontSize.s10,
                          //           0.10,
                          //           ColorManager.textColor),
                          //     ),
                          //     const SizedBox(width: 6),
                          //     const Icon(
                          //       Icons.keyboard_arrow_down,
                          //       size: 12,
                          //     ),
                          //   ],
                          // ),
                        ),
                        CustomRoundButtonWithIcon(
                          title: "Search",
                          fct: () {
                            debugPrint("Search");
                            final salesProvider = Provider.of<SalesProvider>(
                                context,
                                listen: false);
                            String? accessToken =
                                Provider.of<AuthModel>(context, listen: false)
                                    .token;
                            //-------------------------
                            // dateFormatController.text.isEmpty &&
                            //         searchTextController.text.isEmpty
                            //     ? salesProvider.fetchOrders(
                            //         storeId: 1, orderNumberSelect: false)
                            //     :
                            searchTextController.text.isEmpty
                                ? salesProvider.fetchOrders(
                                    accessToken: accessToken ?? '',
                                    storeId: 1,
                                    date: dateFormatController.text,
                                    orderNumberSelect: false,
                                  )
                                : dateFormatController.text.isNotEmpty ||
                                        searchTextController.text.isNotEmpty
                                    ? salesProvider.fetchOrders(
                                        accessToken: accessToken ?? "",
                                        storeId: 1,
                                        orderNumber: searchTextController.text,
                                        orderNumberSelect: true,
                                      )
                                    : salesProvider.fetchOrders(
                                        accessToken: accessToken ?? "",
                                        storeId: 1,
                                        orderNumber: searchTextController.text,
                                        orderNumberSelect: true,
                                      );
                            // salesProvider.fetchOrders(
                            //     storeId: 1, orderNumberSelect: false);
                          },
                          fontSize: 12,
                          height: 45,
                          width: 120,
                          size: size,
                          icon: const Icon(
                            Icons.search_rounded,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    // Align(
                    //   alignment: Alignment.topRight,
                    //   child: Container(
                    //     height: size.height * 0.04,
                    //     width: size.width * 0.09,
                    //     //margin: const EdgeInsets.only(right: 20),

                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(6),
                    //       boxShadow: const [
                    //         BoxShadow(
                    //           color: ColorManager.boxShadowColor,
                    //           blurRadius: 6,
                    //           offset: Offset(1, 1),
                    //         ),
                    //       ],
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: [
                    //         IconButton(
                    //             visualDensity: const VisualDensity(
                    //                 horizontal: 0, vertical: 0),
                    //             padding: EdgeInsets.zero,
                    //             constraints: const BoxConstraints(),
                    //             onPressed: () {
                    //               debugPrint("filter");
                    //             },
                    //             icon: const Icon(
                    //               CustomIcons.iconFilterList,
                    //               color: Colors.black,
                    //               size: 10,
                    //             )),
                    //         Text(
                    //           "Filters",
                    //           style: buildCustomStyle(
                    //             FontWeightManager.semiBold,
                    //             FontSize.s12,
                    //             0.27,
                    //             Colors.black,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                BuildBoxShadowContainer(
                    height: size.height, //120,

                    circleRadius: 7,
                    offsetValue: const Offset(1, 1),
                    child: Consumer<SalesProvider>(
                      builder: (context, orderProvider, child) {
                        List<ListOrderModelData> orders = orderProvider.orders;
                        return Table(
                          columnWidths: const {
                            0: FractionColumnWidth(0.005),
                            1: FractionColumnWidth(0.03),
                            2: FractionColumnWidth(0.03),
                            3: FractionColumnWidth(0.005),
                            4: FractionColumnWidth(0.005),
                            5: FractionColumnWidth(0.02),
                            6: FractionColumnWidth(0.03),
                            7: FractionColumnWidth(0.03),
                            8: FractionColumnWidth(0.08),
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
                                          "Order #",
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
                                          "Quantity",
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
                                          "Offer",
                                          // "Offers Applied",
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
                                          "Store Name",
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
                            ...orders.asMap().entries.map((entry) {
                              int index = entry.key;
                              ListOrderModelData order = entry.value;
                              PriceSummary priceSummary =
                                  order.priceSummary ?? PriceSummary();

                              return TableRow(
                                children: [
                                  TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
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
                                        padding: const EdgeInsets.all(30.0),
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              sideBarController.index.value =
                                                  11;

                                              orderProvider.setOrderId(
                                                  "${order.ordersId ?? "0"}");
                                              // debugPrint(
                                              //     " inside onTap order Details${orderProvider.orderId}");
                                            },
                                            child: Text(
                                              "#${order.orderNumber}",
                                              style: buildCustomStyle(
                                                FontWeightManager.medium,
                                                FontSize.s9,
                                                0.13,
                                                ColorManager.kPrimaryColor
                                                    .withOpacity(0.9),
                                              ),
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
                                            DateHelper.formatYearMonthDay(
                                                order.orderDate!),
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
                                            "${order.totalItems}",
                                            //  " 1 MIGHTY ZINGER BOX 150 g\n2 MIGHTY ZINGER BOX 150 g\n3 MIGHTY ZINGER BOX 150 g",
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
                                            "0% ",
                                            // "0% offer applied",
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
                                            Provider.of<PurchaseProvider>(
                                                    context,
                                                    listen: false)
                                                .getStoreNameFromId(
                                                    order.storeId ?? 0),
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
                                            "Rs ${AmountHelper.formatAmount(priceSummary.netPayable ?? 0.0)}",
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
                                            "${order.customerDetails!.name}\n +91 ${order.customerDetails!.phone}",
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
                                                      orderProvider.setOrderId(
                                                          "${order.ordersId ?? "0"}");
                                                      sideBarController
                                                          .index.value = 11;
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
                                                    onPressed: () async {},
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
                    )),
              ],
            ),
          )),
    );
  }
}

// Table(
//   columnWidths: const {
//     0: FractionColumnWidth(0.01),
//     1: FractionColumnWidth(0.01),
//     2: FractionColumnWidth(0.1),
//     3: FractionColumnWidth(0.06),
//     4: FractionColumnWidth(0.06),
//     5: FractionColumnWidth(0.05),
//   },
//   border: TableBorder.symmetric(
//       outside: BorderSide.none,
//       inside: const BorderSide(
//           color: ColorManager.tableBOrderColor, width: 0.8)),
//   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//   children: [
//     TableRow(
//         decoration: const BoxDecoration(
//             color: ColorManager.tableBGColor),
//         children: [
//           TableCell(
//               verticalAlignment:
//                   TableCellVerticalAlignment.middle,
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Center(
//                     child: Text(
//                   "Order ID",
//                   style: buildCustomStyle(
//                     FontWeightManager.medium,
//                     FontSize.s12,
//                     0.18,
//                     ColorManager.kPrimaryColor,
//                   ),
//                 )),
//               )),
//           TableCell(
//               verticalAlignment:
//                   TableCellVerticalAlignment.middle,
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Center(
//                     child: Text(
//                   "Date",
//                   style: buildCustomStyle(
//                     FontWeightManager.medium,
//                     FontSize.s12,
//                     0.18,
//                     ColorManager.kPrimaryColor,
//                   ),
//                 )),
//               )),
//           TableCell(
//               verticalAlignment:
//                   TableCellVerticalAlignment.middle,
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Center(
//                     child: Text(
//                   "Order Summary",
//                   style: buildCustomStyle(
//                     FontWeightManager.medium,
//                     FontSize.s12,
//                     0.18,
//                     ColorManager.kPrimaryColor,
//                   ),
//                 )),
//               )),
//           TableCell(
//               verticalAlignment:
//                   TableCellVerticalAlignment.middle,
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Center(
//                     child: Text(
//                   "Offers Applied",
//                   style: buildCustomStyle(
//                     FontWeightManager.medium,
//                     FontSize.s12,
//                     0.18,
//                     ColorManager.kPrimaryColor,
//                   ),
//                 )),
//               )),
//           TableCell(
//               verticalAlignment:
//                   TableCellVerticalAlignment.middle,
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Center(
//                     child: Text(
//                   "Payment summary",
//                   style: buildCustomStyle(
//                     FontWeightManager.medium,
//                     FontSize.s12,
//                     0.18,
//                     ColorManager.kPrimaryColor,
//                   ),
//                 )),
//               )),
//           TableCell(
//               verticalAlignment:
//                   TableCellVerticalAlignment.middle,
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Center(
//                     child: Text(
//                   "Customer Details",
//                   style: buildCustomStyle(
//                     FontWeightManager.medium,
//                     FontSize.s12,
//                     0.18,
//                     ColorManager.kPrimaryColor,
//                   ),
//                 )),
//               )),
//         ]),
//     ...List.generate(
//       6,
//       (index) => TableRow(
//         children: [
//           TableCell(
//               verticalAlignment:
//                   TableCellVerticalAlignment.middle,
//               child: Padding(
//                 padding: const EdgeInsets.all(30.0),
//                 child: Center(
//                   child: Text(
//                     "#34566",
//                     style: buildCustomStyle(
//                       FontWeightManager.medium,
//                       FontSize.s9,
//                       0.13,
//                       Colors.black,
//                     ),
//                   ),
//                 ),
//               )),
//           TableCell(
//               verticalAlignment:
//                   TableCellVerticalAlignment.middle,
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Center(
//                   child: Text(
//                     "25/06/2022",
//                     style: buildCustomStyle(
//                       FontWeightManager.medium,
//                       FontSize.s9,
//                       0.13,
//                       Colors.black,
//                     ),
//                   ),
//                 ),
//               )),
//           TableCell(
//               verticalAlignment:
//                   TableCellVerticalAlignment.middle,
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Center(
//                   child: Text(
//                     " 1 MIGHTY ZINGER BOX 150 g\n2 MIGHTY ZINGER BOX 150 g\n3 MIGHTY ZINGER BOX 150 g",
//                     style: buildCustomStyle(
//                       FontWeightManager.medium,
//                       FontSize.s9,
//                       0.13,
//                       Colors.black,
//                     ),
//                   ),
//                 ),
//               )),
//           TableCell(
//               verticalAlignment:
//                   TableCellVerticalAlignment.middle,
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Center(
//                   child: Text(
//                     "20% offer applied\n20% offer applied\n20% offer applied",
//                     style: buildCustomStyle(
//                       FontWeightManager.medium,
//                       FontSize.s9,
//                       0.13,
//                       ColorManager.kPrimaryColor,
//                     ),
//                   ),
//                 ),
//               )),
//           TableCell(
//               verticalAlignment:
//                   TableCellVerticalAlignment.middle,
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Center(
//                   child: Text(
//                     "\$115.00",
//                     style: buildCustomStyle(
//                       FontWeightManager.medium,
//                       FontSize.s9,
//                       0.13,
//                       Colors.black,
//                     ),
//                   ),
//                 ),
//               )),
//           TableCell(
//               verticalAlignment:
//                   TableCellVerticalAlignment.middle,
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Center(
//                   child: Text(
//                     "Iris Watson\n +91 6845567860",
//                     style: buildCustomStyle(
//                       FontWeightManager.medium,
//                       FontSize.s9,
//                       0.13,
//                       Colors.black,
//                     ),
//                   ),
//                 ),
//               )),
//         ],
//       ),
//     ),
//   ],
// ),
