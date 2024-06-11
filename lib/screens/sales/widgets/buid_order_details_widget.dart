import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../components/build_container_box.dart';
import '../../../components/build_payment_row.dart';
import '../../../components/build_profile_picture.dart';
import '../../../models/order_details.dart';
import '../../../resources/asset_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/style_manager.dart';
import '../../../responsive.dart';

class OrderDetailWidget extends StatelessWidget {
  final OrderDetailsModelData? orderDetailsModelData;
  final OrderDetailsModelDataCustomerDetails? customerDetails;
  final List<OrderDetailsModelDataCart>? cart;
  final List<OrderDetailsModelDataCartItem>? cartItem;
  final OrderDetailsModelDataPriceSummary? priceSummary;
  const OrderDetailWidget(
      {super.key,
      required this.orderDetailsModelData,
      required this.cart,
      required this.priceSummary,
      required this.cartItem,
      required this.customerDetails});

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        children: [
          BuildBoxShadowContainer(
            circleRadius: 7,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 13.0, left: 8, right: 8),
            offsetValue: const Offset(1, 1),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '${customerDetails!.name}\n',
                        style: ResponsiveWidget.isMobile(context)
                            ? buildCustomStyle(FontWeightManager.semiBold,
                                FontSize.s12, 0.30, ColorManager.textColor)
                            : buildCustomStyle(FontWeightManager.semiBold,
                                FontSize.s24, 0.35, ColorManager.textColor),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${orderDetailsModelData!.orderDate}',
                            style: buildCustomStyle(
                                FontWeightManager.medium,
                                FontSize.s13,
                                0.20,
                                ColorManager.blackWithOpacity50),
                          ),
                        ],
                      ),
                    ),
                    const BuildProfilePicture()
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: ColorManager.kPrimaryWithOpacity10,
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: 'Note\n',
                      style: buildCustomStyle(FontWeightManager.medium,
                          FontSize.s15, 0.23, ColorManager.kPrimaryColor),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Waiting for friends.',
                          style: buildCustomStyle(FontWeightManager.medium,
                              FontSize.s12, 0.18, Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: cartItem!.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          //horizontalTitleGap: 0,
                          minLeadingWidth: 0,
                          minVerticalPadding: 0,
                          contentPadding: EdgeInsets.zero,
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: 0),

                          leading: Text(
                            '${index + 1}',
                            style: buildCustomStyle(FontWeightManager.regular,
                                FontSize.s15, 0.23, Colors.black),
                          ),

                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: '${cartItem![index].productName}\n',
                                  style: buildCustomStyle(
                                      FontWeightManager.regular,
                                      FontSize.s13,
                                      0.20,
                                      Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          '${cartItem![index].quantity} * ${cartItem![index].productUnit}',
                                      style: buildCustomStyle(
                                          FontWeightManager.medium,
                                          FontSize.s9,
                                          0.13,
                                          ColorManager.blackWithOpacity50),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${cartItem![index].currency} ${cartItem![index].unitPrice}',
                                style: buildCustomStyle(
                                    FontWeightManager.regular,
                                    FontSize.s14,
                                    0.21,
                                    ColorManager.blackWithOpacity50),
                              ),
                            ],
                          ),

                          trailing: WebsafeSvg.asset(
                            ImageAssets.oderlistCloseIcon,
                            fit: BoxFit.fill,
                          ),
                          //   ],
                        );
                      }),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Column(
                      children: [
                        BuildPaymentRow(
                          amount: "${priceSummary!.netTotal}.00",
                          title: "Net amount",
                          color: ColorManager.textColor,
                        ),
                        BuildPaymentRow(
                          amount: "${priceSummary!.discount}.00",
                          title: "Discount",
                          color: ColorManager.textColor,
                        ),
                        BuildPaymentRow(
                          amount: "${priceSummary!.totalTax}.00",
                          title: "Tax Amount",
                          color: ColorManager.textColor,
                        ),
                        const Divider(thickness: 2),
                        BuildPaymentRow(
                          amount: "${priceSummary!.netPayable}.00",
                          title: "Payable",
                          secondRowTextStyle: buildCustomStyle(
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
                          amount: "Rs 0.00",
                          title: "Balance amount",
                          secondRowTextStyle: buildCustomStyle(
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     CustomRoundButtonWithIcon(
                //       title: "Resume",
                //       size: size,
                //       radius: 4,
                //       fct: () {},
                //       fontSize: FontSize.s12,
                //       height: 40,
                //       width: 120,
                //       icon: const Icon(
                //         Icons.play_circle_outline_outlined,
                //         color: Colors.white,
                //       ),
                //     ),
                //     CustomRoundButtonWithIcon(
                //         radius: 4,
                //         size: size,
                //         icon: const Icon(
                //           Icons.delete,
                //           color: ColorManager.kPrimaryColor,
                //         ),
                //         boxColor: Colors.transparent,
                //         borderColor: ColorManager.kPrimaryColor,
                //         textColor: ColorManager.kPrimaryColor,
                //         title: "Remove",
                //         fct: () {},
                //         fontSize: FontSize.s12,
                //         height: 40,
                //         width: 120),
                //   ],
                // ),
              ],
            ),
          ),
          // BuildBoxShadowContainer(
          //   circleRadius: 7,
          //   margin: const EdgeInsets.only(
          //     top: 13.0,
          //     left: 8,
          //     right: 8,
          //     bottom: 13.0,
          //   ),
          //   padding: const EdgeInsets.all(20),
          //   offsetValue: const Offset(1, 1),
          //   child: Column(
          //     children: [
          //       Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             RichText(
          //               text: TextSpan(
          //                 text: 'Vincent Lodo\n',
          //                 style: ResponsiveWidget.isMobile(context)
          //                     ? buildCustomStyle(FontWeightManager.semiBold,
          //                         FontSize.s12, 0.30, ColorManager.textColor)
          //                     : buildCustomStyle(FontWeightManager.semiBold,
          //                         FontSize.s24, 0.35, ColorManager.textColor),
          //                 children: <TextSpan>[
          //                   TextSpan(
          //                     text: '26 Feb 2021, 16:50:32',
          //                     style: buildCustomStyle(
          //                         FontWeightManager.medium,
          //                         FontSize.s13,
          //                         0.20,
          //                         ColorManager.blackWithOpacity50),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             const BuildProfilePicture(),
          //           ]),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
