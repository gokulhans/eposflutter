import 'package:flutter/material.dart';

import 'package:pos_machine/components/build_container_box.dart';
import 'package:pos_machine/components/build_round_button.dart';
import 'package:pos_machine/resources/asset_manager.dart';
import 'package:pos_machine/resources/font_manager.dart';
import 'package:pos_machine/resources/style_manager.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../components/build_payment_row.dart';

import '../resources/color_manager.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final TextEditingController mobileNumberTextController =
      TextEditingController();
  bool expanded = false;
  bool expanded1 = false;
  bool iconColor = true;
  UniqueKey keyTile = UniqueKey();
  UniqueKey keyTile1 = UniqueKey();
  void expandTile() {
    setState(() {
      expanded = true;
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
      expanded = false;
      keyTile = UniqueKey();
    });
  }

  void expandTile1() {
    setState(() {
      expanded1 = true;
      keyTile1 = UniqueKey();
    });
  }

  void shrinkTile1() {
    setState(() {
      expanded1 = false;
      keyTile1 = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          margin:
              const EdgeInsets.only(left: 10, top: 20, bottom: 10, right: 10),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              boxShadow: const [
                BoxShadow(
                  color: ColorManager.boxShadowColor,
                  blurRadius: 6,
                  offset: Offset(1, 1),
                ),
              ],
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order List',
                      style: buildCustomStyle(FontWeightManager.semiBold,
                          FontSize.s20, 0.30, ColorManager.textColor),
                    ),
                    Row(
                      children: [
                        BuildBoxShadowContainer(
                          height: 29,
                          width: 30,
                          circleRadius: 7,
                          child: WebsafeSvg.asset(
                            ImageAssets.deleteIcon,
                            fit: BoxFit.none,
                          ),
                        ),
                        const SizedBox(width: 15),
                        WebsafeSvg.asset(
                          ImageAssets.verticalDotsIcon,
                          fit: BoxFit.none,
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  'Transaction #30012',
                  style: buildCustomStyle(FontWeightManager.regular,
                      FontSize.s12, 0.18, ColorManager.textColor),
                ),
                const Divider(thickness: 1),
                Text(
                  'Enter mobile number',
                  style: buildCustomStyle(FontWeightManager.regular,
                      FontSize.s10, 0.16, ColorManager.textColor),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: BuildBoxShadowContainer(
                        padding: const EdgeInsets.all(10),
                        height: 30,
                        // width: 250,
                        circleRadius: 5,
                        alignment: Alignment.center,
                        child: TextField(
                          textAlign: TextAlign.start,
                          style: buildCustomStyle(FontWeightManager.regular,
                              FontSize.s8, 0.16, ColorManager.textColor),
                          controller: mobileNumberTextController,
                          cursorHeight: 10,
                          cursorWidth: 1,
                          cursorColor: ColorManager.kPrimaryColor,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    BuildBoxShadowContainer(
                      height: 25,
                      width: 25,
                      circleRadius: 5,
                      child: WebsafeSvg.asset(
                        ImageAssets.userIcon,
                        fit: BoxFit.none,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: size.height * 0.2, // 150,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Theme(
                          data: ThemeData(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            maintainState: true,
                            childrenPadding: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            collapsedBackgroundColor: index % 2 == 0
                                ? Colors.grey.withOpacity(0.1)
                                : null,
                            backgroundColor: index % 2 == 0
                                ? Colors.grey.withOpacity(0.1)
                                : null,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                            tilePadding:
                                const EdgeInsets.only(right: 10, left: 5),
                            key: keyTile,
                            // leading: Text(
                            //   '${index + 1}',
                            //   style: buildCustomStyle(FontWeightManager.regular,
                            //       FontSize.s10, 0.21, ColorManager.textColor),
                            // ),
                            trailing: WebsafeSvg.asset(
                              ImageAssets.oderlistCloseIcon,
                              fit: BoxFit.none,
                            ), //const SizedBox(),
                            initiallyExpanded: expanded,
                            // leading: expanded
                            //     ? GestureDetector(
                            //         onTap: () {
                            //           // shrinkTile();
                            //         },
                            //         child: const Icon(
                            //           Icons.keyboard_arrow_down,
                            //         ),
                            //       )
                            //     : GestureDetector(
                            //         onTap: () {
                            //           //  expandTile();
                            //         },
                            //         child: const Icon(
                            //           Icons.keyboard_arrow_right,
                            //         ),
                            //       ),
                            controlAffinity: ListTileControlAffinity.leading,
                            iconColor: ColorManager.textColor,
                            collapsedIconColor: ColorManager.textColor,
                            title: ListTile(
                              //horizontalTitleGap: 0,
                              minLeadingWidth: 0, minVerticalPadding: 0,
                              contentPadding: EdgeInsets.zero,
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: 0),
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // children: [
                              //const SizedBox(width: 5),
                              leading: Text(
                                '${index + 1}',
                                style: buildCustomStyle(
                                    FontWeightManager.regular,
                                    FontSize.s10,
                                    0.21,
                                    ColorManager.textColor),
                              ),
                              //  const SizedBox(width: 10),
                              // subtitle: Text(
                              //   '\$25.00',
                              //   style: buildCustomStyle(FontWeightManager.regular,
                              //       FontSize.s10, 0.21, ColorManager.textColor),
                              // ),
                              title: RichText(
                                text: TextSpan(
                                  text: 'MIGHTY ZINGER BOX\n',
                                  style: buildCustomStyle(
                                      FontWeightManager.regular,
                                      FontSize.s10,
                                      0.21,
                                      ColorManager.textColor),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '150 g',
                                      style: buildCustomStyle(
                                          FontWeightManager.medium,
                                          FontSize.s8,
                                          0.21,
                                          ColorManager.textColor),
                                    ),
                                  ],
                                ),
                              ),
                              // Text(
                              //   '150 g',
                              //   style: buildCustomStyle(FontWeightManager.medium,
                              //       FontSize.s8, 0.21, ColorManager.textColor),
                              // ),

                              //  const SizedBox(width: 20),
                              trailing: Text(
                                '\$25.00',
                                style: buildCustomStyle(
                                    FontWeightManager.regular,
                                    FontSize.s10,
                                    0.21,
                                    ColorManager.textColor),
                              ),
                              //  const SizedBox(width: 20),
                              // trailing: WebsafeSvg.asset(
                              //   ImageAssets.oderlistCloseIcon,
                              //   fit: BoxFit.none,
                              // ),
                              //   ],
                            ),
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Quantity',
                                          style: buildCustomStyle(
                                              FontWeightManager.regular,
                                              FontSize.s10,
                                              0.21,
                                              ColorManager.textColor),
                                        ),
                                        SizedBox(
                                          height: 25,
                                          width: 100,
                                          child: TextField(
                                            cursorWidth: 1,
                                            // controller: _searchTextController,
                                            cursorColor:
                                                ColorManager.kPrimaryColor,
                                            decoration:
                                                decorationBorder.copyWith(
                                              labelStyle: buildCustomStyle(
                                                  FontWeightManager.regular,
                                                  FontSize.s10,
                                                  0.10,
                                                  ColorManager.textColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      children: [
                                        Text(
                                          'Discount(%)',
                                          style: buildCustomStyle(
                                              FontWeightManager.regular,
                                              FontSize.s10,
                                              0.21,
                                              ColorManager.textColor),
                                        ),
                                        SizedBox(
                                          height: 25,
                                          width: 100,
                                          child: TextField(
                                            cursorWidth: 1,
                                            // controller: _searchTextController,
                                            cursorColor:
                                                ColorManager.kPrimaryColor,
                                            decoration:
                                                decorationBorder.copyWith(
                                              labelStyle: buildCustomStyle(
                                                  FontWeightManager.regular,
                                                  FontSize.s10,
                                                  0.10,
                                                  ColorManager.textColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomRoundButton(
                      title: "Cash",
                      fct: () {},
                      fontSize: FontSize.s12,
                      height: 40,
                      width: 120,
                    ),
                    BuildBoxShadowContainer(
                      blurRadius: 4,
                      circleRadius: 5,
                      child: CustomRoundButton(
                          boxColor: Colors.transparent,
                          borderColor: Colors.white,
                          textColor: ColorManager.kPrimaryColor,
                          title: "Details",
                          fct: () {},
                          fontSize: FontSize.s12,
                          height: 40,
                          width: 120),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: size.height * 0.38, // 280,
                  margin: const EdgeInsets.only(
                      left: 10, top: 20, bottom: 10, right: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0.0),
                          bottomRight: Radius.circular(13.0),
                          topLeft: Radius.circular(0.0),
                          bottomLeft: Radius.circular(13.0)),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.boxShadowColor,
                          blurRadius: 4,
                          offset: Offset(1, 1),
                        ),
                      ],
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 8, bottom: 0),
                    child: Column(
                      children: [
                        const BuildPaymentRow(
                          amount: "\$75.00",
                          title: "Net amount",
                          color: ColorManager.textColor,
                        ),
                        const BuildPaymentRow(
                          amount: "\$20.00",
                          title: "Discount",
                          color: ColorManager.textColor,
                        ),
                        const BuildPaymentRow(
                          amount: "\$20.00",
                          title: "Tax Amount",
                          color: ColorManager.textColor,
                        ),
                        const Divider(thickness: 2),
                        BuildPaymentRow(
                          amount: "\$115.00",
                          title: "Payable",
                          secondtRowTextStyle: buildCustomStyle(
                            FontWeightManager.bold,
                            FontSize.s15,
                            0.23,
                            ColorManager.textColor,
                          ),
                          firstRowTextStyle: buildCustomStyle(
                            FontWeightManager.bold,
                            FontSize.s15,
                            0.23,
                            ColorManager.textColor,
                          ),
                          color: ColorManager.textColor,
                        ),
                        BuildPaymentRow(
                          amount: "\$100.00",
                          title: "Balance amount",
                          secondtRowTextStyle: buildCustomStyle(
                            FontWeightManager.medium,
                            FontSize.s12,
                            0.18,
                            ColorManager.textColorRed,
                          ),
                          firstRowTextStyle: buildCustomStyle(
                            FontWeightManager.bold,
                            FontSize.s15,
                            0.23,
                            ColorManager.textColorRed,
                          ),
                          color: ColorManager.textColorRed,
                        ),
                        const SizedBox(height: 5),
                        BuildPaymentRow(
                          amount: "",
                          title: "Payment Method",
                          firstRowTextStyle: buildCustomStyle(
                            FontWeightManager.semiBold,
                            FontSize.s14,
                            0.21,
                            ColorManager.kPrimaryColor,
                          ),
                          color: ColorManager.kPrimaryColor,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  iconColor = !iconColor;
                                });
                              },
                              child: BuildBoxShadowContainer(
                                border: iconColor
                                    ? Border.all(
                                        color: ColorManager.kPrimaryColor)
                                    : null,
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.all(8),
                                blurRadius: 4,
                                circleRadius: 5,
                                child: Column(
                                  children: [
                                    WebsafeSvg.asset(
                                      ImageAssets.cashIcon,
                                      color: Colors.black,
                                      fit: BoxFit.none,
                                    ),
                                    Text(
                                      'Cash',
                                      style: buildCustomStyle(
                                          FontWeightManager.medium,
                                          FontSize.s8,
                                          0.12,
                                          Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  iconColor = !iconColor;
                                });
                              },
                              child: BuildBoxShadowContainer(
                                border: !iconColor
                                    ? Border.all(
                                        color: ColorManager.kPrimaryColor)
                                    : null,
                                margin:
                                    const EdgeInsets.only(left: 10, top: 10),
                                padding: const EdgeInsets.only(
                                    left: 12, top: 8, bottom: 8, right: 12),
                                blurRadius: 4,
                                circleRadius: 5,
                                child: Column(
                                  children: [
                                    WebsafeSvg.asset(
                                      ImageAssets.creditCardIcon,
                                      color: Colors.black,
                                      fit: BoxFit.none,
                                    ),
                                    Text(
                                      'Card',
                                      style: buildCustomStyle(
                                          FontWeightManager.medium,
                                          FontSize.s8,
                                          0.12,
                                          Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 55,
                margin: const EdgeInsets.only(
                    left: 10, top: 20, bottom: 10, right: 10),
                //  padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(0.0),
                        bottomRight: Radius.circular(13.0),
                        topLeft: Radius.circular(0.0),
                        bottomLeft: Radius.circular(13.0)),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.boxShadowColor,
                        blurRadius: 6,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: ColorManager.greyWithOpacity60),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            WebsafeSvg.asset(
                              ImageAssets.printIcon,
                              color: Colors.white,
                              fit: BoxFit.none,
                            ),
                            Text(
                              'Print',
                              style: buildCustomStyle(FontWeightManager.medium,
                                  FontSize.s10, 0.16, Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(0.0),
                                bottomRight: Radius.circular(13.0),
                                topLeft: Radius.circular(0.0),
                                bottomLeft: Radius.circular(0.0)),
                            boxShadow: [
                              BoxShadow(
                                color: ColorManager.boxShadowColor,
                                blurRadius: 6,
                                offset: Offset(1, 1),
                              ),
                            ],
                            color: ColorManager.kPrimaryColor,
                          ),
                          child: Text(
                            'Pay \$215.00',
                            style: buildCustomStyle(FontWeightManager.medium,
                                FontSize.s18, 0.27, Colors.white),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


 // const SizedBox(height: 10),
                    // Theme(
                    //   data: ThemeData(dividerColor: Colors.transparent),
                    //   child: ExpansionTile(
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(3)),
                    //     childrenPadding: const EdgeInsets.only(bottom: 10),
                    //     tilePadding: EdgeInsets.zero,
                    //     key: keyTile1,
                    //     trailing: const SizedBox(),
                    //     initiallyExpanded: expanded1,
                    //     leading: expanded1
                    //         ? GestureDetector(
                    //             onTap: () {
                    //               shrinkTile1();
                    //             },
                    //             child: const Icon(
                    //               Icons.keyboard_arrow_down,
                    //             ),
                    //           )
                    //         : GestureDetector(
                    //             onTap: () {
                    //               expandTile1();
                    //             },
                    //             child: const Icon(
                    //               Icons.keyboard_arrow_right,
                    //             ),
                    //           ),
                    //     iconColor: ColorManager.textColor,
                    //     collapsedIconColor: ColorManager.textColor,
                    //     title: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         // const SizedBox(width: 5),
                    //         Text(
                    //           '2',
                    //           style: buildCustomStyle(FontWeightManager.regular,
                    //               FontSize.s10, 0.21, ColorManager.textColor),
                    //         ),
                    //         //  const SizedBox(width: 10),
                    //         Column(
                    //           mainAxisSize: MainAxisSize.min,
                    //           children: [
                    //             Text(
                    //               'MIGHTY ZINGER BOX',
                    //               style: buildCustomStyle(FontWeightManager.regular,
                    //                   FontSize.s10, 0.21, ColorManager.textColor),
                    //             ),
                    //             Text(
                    //               '150 g',
                    //               style: buildCustomStyle(FontWeightManager.medium,
                    //                   FontSize.s8, 0.21, ColorManager.textColor),
                    //             ),
                    //           ],
                    //         ),
                    //         const SizedBox(width: 20),
                    //         Text(
                    //           '\$25.00',
                    //           style: buildCustomStyle(FontWeightManager.regular,
                    //               FontSize.s10, 0.21, ColorManager.textColor),
                    //         ),
                    //         const SizedBox(width: 15),
                    //         WebsafeSvg.asset(
                    //           ImageAssets.oderlistCloseIcon,
                    //           fit: BoxFit.none,
                    //         ),
                    //       ],
                    //     ),
                    //     children: <Widget>[
                    //       Padding(
                    //         padding: const EdgeInsets.only(left: 10, right: 10),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Column(
                    //               children: [
                    //                 Text(
                    //                   'Quantity',
                    //                   style: buildCustomStyle(
                    //                       FontWeightManager.regular,
                    //                       FontSize.s10,
                    //                       0.21,
                    //                       ColorManager.textColor),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 25,
                    //                   width: 100,
                    //                   child: TextField(
                    //                     cursorWidth: 1,
                    //                     // controller: _searchTextController,
                    //                     cursorColor: ColorManager.kPrimaryColor,
                    //                     decoration: decorationBorder.copyWith(
                    //                       labelStyle: buildCustomStyle(
                    //                           FontWeightManager.regular,
                    //                           FontSize.s10,
                    //                           0.10,
                    //                           ColorManager.textColor),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             const SizedBox(width: 10),
                    //             Column(
                    //               children: [
                    //                 Text(
                    //                   'Discount(%)',
                    //                   style: buildCustomStyle(
                    //                       FontWeightManager.regular,
                    //                       FontSize.s10,
                    //                       0.21,
                    //                       ColorManager.textColor),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 25,
                    //                   width: 100,
                    //                   child: TextField(
                    //                     cursorWidth: 1,
                    //                     // controller: _searchTextController,
                    //                     cursorColor: ColorManager.kPrimaryColor,
                    //                     decoration: decorationBorder.copyWith(
                    //                       labelStyle: buildCustomStyle(
                    //                           FontWeightManager.regular,
                    //                           FontSize.s10,
                    //                           0.10,
                    //                           ColorManager.textColor),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    //      ),
                    //   ],