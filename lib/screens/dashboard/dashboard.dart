import 'package:flutter/material.dart';
import 'package:pos_machine/components/build_container_box.dart';
import 'package:pos_machine/components/build_round_button.dart';
import 'package:pos_machine/providers/auth_model.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../models/dashboard.dart';
import '../../providers/dashboard_provider.dart';
import '../../resources/asset_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/style_manager.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isInitLoading = false;
  DashBoardModelData? dashBoardModelData;
  Total? totalSales;
  Total? totalCustomers;
  String value = 'today';
  @override
  void initState() {
    super.initState();
    getDashBoardDetails();
  }

  void getDashBoardDetails() async {
    try {
      setState(() {
        isInitLoading = true;
      });
      String? accessToken =
          Provider.of<AuthModel>(context, listen: false).token;
      debugPrint("accessToken From AuthModel $accessToken");
      DashboardProvider()
          .dashbaord(accessToken ?? "", context)
          .then((response) {
        if (response["status"] == "success") {
          setState(() {
            DashBoardModel dashBoardModel = DashBoardModel.fromJson(response);
            dashBoardModelData = dashBoardModel.data;
            totalCustomers = dashBoardModelData!.totalCustomers;
            totalSales = dashBoardModelData!.totalSales;
          });
        } else {}
      });
      // DashboardProvider().listCartItnes(context).then((value) {
      //   debugPrint("listCartItems Listing");
      //   debugPrint(value["status"]);
      // });
    } catch (error) {
      debugPrint(error.toString());
    } finally {
      setState(() {
        isInitLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isInitLoading
        ? SizedBox(
            height: size.height,
            child: const CircularProgressIndicator.adaptive())
        : Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dashboard ",
                        style: buildCustomStyle(FontWeightManager.semiBold,
                            FontSize.s20, 0.30, ColorManager.textColor),
                      ),
                      Row(
                        children: [
                          CustomRoundButtonWithIcon(
                            title: "Download Report",
                            fct: () {},
                            fontSize: 10,
                            height: 50,
                            width: 150,
                            size: size,
                            icon: const Icon(
                              Icons.download_outlined,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                          BuildBoxShadowContainer(
                              padding: const EdgeInsets.all(15),
                              height: 50,
                              width: 150,
                              circleRadius: 4,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    size: 10,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "6,April,2022",
                                    style: buildCustomStyle(
                                        FontWeightManager.medium,
                                        FontSize.s10,
                                        0.10,
                                        ColorManager.textColor),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 12,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today’s Sales ",
                        style: buildCustomStyle(FontWeightManager.semiBold,
                            FontSize.s15, 0.23, ColorManager.textColor),
                      ),
                      BuildBoxShadowContainer(
                        padding: const EdgeInsets.only(left: 20),
                        height: 30,
                        width: 80,
                        circleRadius: 4,
                        child: DropdownButton<String>(
                          value: value, // Set the initial value
                          onChanged: (String? newValue) {
                            setState(() {
                              value = newValue ?? "today";
                            });
                            // Handle the dropdown value change
                            // Typically, you would setState to update the dropdown value in your stateful widget
                          },
                          items: <String>['today', 'week', 'month', 'year']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),

                          style: buildCustomStyle(FontWeightManager.medium,
                              FontSize.s8, 0.10, ColorManager.textColor),
                          // Hide the underline by setting the underline property to an empty container
                          underline: Container(),
                        ),

                        // Row(
                        //   children: [
                        //     const SizedBox(width: 6),
                        //     Text(
                        //       "Today",
                        //       style: buildCustomStyle(FontWeightManager.medium,
                        //           FontSize.s8, 0.10, ColorManager.textColor),
                        //     ),
                        //     const SizedBox(width: 6),
                        //     const Icon(
                        //       Icons.keyboard_arrow_down,
                        //       size: 12,
                        //     ),
                        //   ],
                        // ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 165,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        BuildBoxShadowContainer(
                            margin: const EdgeInsets.all(15),
                            padding: const EdgeInsets.all(15),
                            height: 136,
                            width: 240,
                            circleRadius: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: ColorManager.kPrimaryColor,
                                  child: Icon(
                                    Icons.calculate_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                isInitLoading || dashBoardModelData == null
                                    ? Text(
                                        "0",
                                        style: buildCustomStyle(
                                            FontWeightManager.semiBold,
                                            FontSize.s25,
                                            0.38,
                                            ColorManager.textColor),
                                      )
                                    : value == "today"
                                        ? Text(
                                            "${totalSales!.today}",
                                            style: buildCustomStyle(
                                                FontWeightManager.semiBold,
                                                FontSize.s25,
                                                0.38,
                                                ColorManager.textColor),
                                          )
                                        : value == "week"
                                            ? Text("${totalSales!.week}",
                                                style: buildCustomStyle(
                                                    FontWeightManager.semiBold,
                                                    FontSize.s25,
                                                    0.38,
                                                    ColorManager.textColor))
                                            : value == "month"
                                                ? Text("${totalSales!.month}",
                                                    style: buildCustomStyle(
                                                        FontWeightManager
                                                            .semiBold,
                                                        FontSize.s25,
                                                        0.38,
                                                        ColorManager.textColor))
                                                : Text(
                                                    "0",
                                                    style: buildCustomStyle(
                                                        FontWeightManager
                                                            .semiBold,
                                                        FontSize.s25,
                                                        0.38,
                                                        ColorManager.textColor),
                                                  ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Count",
                                      style: buildCustomStyle(
                                          FontWeightManager.medium,
                                          FontSize.s15,
                                          0.23,
                                          ColorManager.textColor),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ColorManager
                                                  .kGreenWithOpacity),
                                          child: const Icon(
                                            Icons.arrow_forward,
                                            size: 15,
                                            color: ColorManager.kGreen,
                                          ),
                                        ),
                                        Text(
                                          "+ 0 %",
                                          style: buildCustomStyle(
                                              FontWeightManager.medium,
                                              FontSize.s15,
                                              0.23,
                                              ColorManager.kGreen),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        BuildBoxShadowContainer(
                            margin: const EdgeInsets.all(15),
                            padding: const EdgeInsets.all(15),
                            height: 136,
                            width: 240,
                            circleRadius: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: ColorManager.kMagentha,
                                  child: Icon(
                                    Icons.calculate_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // isInitLoading || dashBoardModelData == null
                                //     ?
                                Text(
                                  "0",
                                  style: buildCustomStyle(
                                      FontWeightManager.semiBold,
                                      FontSize.s25,
                                      0.38,
                                      ColorManager.textColor),
                                ),
                                // : value == "today"
                                //     ? Text(
                                //         "${totalCustomers!.today}",
                                //         style: buildCustomStyle(
                                //             FontWeightManager.semiBold,
                                //             FontSize.s25,
                                //             0.38,
                                //             ColorManager.textColor),
                                //       )
                                //     : value == "week"
                                //         ? Text("${totalCustomers!.week}",
                                //             style: buildCustomStyle(
                                //                 FontWeightManager.semiBold,
                                //                 FontSize.s25,
                                //                 0.38,
                                //                 ColorManager.textColor))
                                //         : value == "month"
                                //             ? Text(
                                //                 "${totalCustomers!.month}",
                                //                 style: buildCustomStyle(
                                //                     FontWeightManager
                                //                         .semiBold,
                                //                     FontSize.s25,
                                //                     0.38,
                                //                     ColorManager.textColor))
                                //             : Text(
                                //                 "0",
                                //                 style: buildCustomStyle(
                                //                     FontWeightManager
                                //                         .semiBold,
                                //                     FontSize.s25,
                                //                     0.38,
                                //                     ColorManager.textColor),
                                //               ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Amount",
                                      style: buildCustomStyle(
                                          FontWeightManager.medium,
                                          FontSize.s15,
                                          0.23,
                                          ColorManager.textColor),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ColorManager
                                                  .kMaroonWithOpacity),
                                          child: const Icon(
                                            Icons.arrow_forward,
                                            size: 15,
                                            color: ColorManager.kMaroon,
                                          ),
                                        ),
                                        Text(
                                          "+ 0 %",
                                          style: buildCustomStyle(
                                              FontWeightManager.medium,
                                              FontSize.s15,
                                              0.23,
                                              ColorManager.kMaroon),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        BuildBoxShadowContainer(
                            margin: const EdgeInsets.all(15),
                            padding: const EdgeInsets.all(15),
                            height: 136,
                            width: 220,
                            circleRadius: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: ColorManager.kOrange,
                                  child: Icon(
                                    Icons.calculate_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                isInitLoading || dashBoardModelData == null
                                    ? Text(
                                        "0",
                                        style: buildCustomStyle(
                                            FontWeightManager.semiBold,
                                            FontSize.s25,
                                            0.38,
                                            ColorManager.textColor),
                                      )
                                    : value == "today"
                                        ? Text(
                                            "${totalCustomers!.today}",
                                            style: buildCustomStyle(
                                                FontWeightManager.semiBold,
                                                FontSize.s25,
                                                0.38,
                                                ColorManager.textColor),
                                          )
                                        : value == "week"
                                            ? Text("${totalCustomers!.week}",
                                                style: buildCustomStyle(
                                                    FontWeightManager.semiBold,
                                                    FontSize.s25,
                                                    0.38,
                                                    ColorManager.textColor))
                                            : value == "month"
                                                ? Text(
                                                    "${totalCustomers!.month}",
                                                    style: buildCustomStyle(
                                                        FontWeightManager
                                                            .semiBold,
                                                        FontSize.s25,
                                                        0.38,
                                                        ColorManager.textColor))
                                                : Text(
                                                    "0",
                                                    style: buildCustomStyle(
                                                        FontWeightManager
                                                            .semiBold,
                                                        FontSize.s25,
                                                        0.38,
                                                        ColorManager.textColor),
                                                  ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Customers",
                                      style: buildCustomStyle(
                                          FontWeightManager.medium,
                                          FontSize.s15,
                                          0.23,
                                          ColorManager.textColor),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ColorManager
                                                  .kGreenWithOpacity),
                                          child: const Icon(
                                            Icons.arrow_forward,
                                            size: 15,
                                            color: ColorManager.kGreen,
                                          ),
                                        ),
                                        Text(
                                          "+ 0 %",
                                          style: buildCustomStyle(
                                              FontWeightManager.medium,
                                              FontSize.s15,
                                              0.23,
                                              ColorManager.kGreen),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 240,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sales Overview",
                                style: buildCustomStyle(
                                    FontWeightManager.semiBold,
                                    FontSize.s15,
                                    0.23,
                                    ColorManager.textColor),
                              ),
                              BuildBoxShadowContainer(
                                  margin: const EdgeInsets.all(15),
                                  padding: const EdgeInsets.all(15),
                                  height: 180,
                                  // width: 220,
                                  circleRadius: 7,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          BuildBoxShadowContainer(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              height: 30,
                                              width: 80,
                                              circleRadius: 4,
                                              child: Row(
                                                children: [
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    "Today",
                                                    style: buildCustomStyle(
                                                        FontWeightManager
                                                            .medium,
                                                        FontSize.s8,
                                                        0.10,
                                                        ColorManager.textColor),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  const Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size: 12,
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Analytics",
                                style: buildCustomStyle(
                                    FontWeightManager.semiBold,
                                    FontSize.s15,
                                    0.23,
                                    ColorManager.textColor),
                              ),
                              BuildBoxShadowContainer(
                                  margin: const EdgeInsets.all(15),
                                  padding: const EdgeInsets.all(15),
                                  height: 180,
                                  // width: 220,
                                  circleRadius: 7,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          BuildBoxShadowContainer(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              height: 30,
                                              width: 80,
                                              circleRadius: 4,
                                              child: Row(
                                                children: [
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    "Today",
                                                    style: buildCustomStyle(
                                                        FontWeightManager
                                                            .medium,
                                                        FontSize.s8,
                                                        0.10,
                                                        ColorManager.textColor),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  const Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size: 12,
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Quick Access ",
                    style: buildCustomStyle(FontWeightManager.semiBold,
                        FontSize.s15, 0.23, ColorManager.textColor),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      QuickAccessCard(
                        onTap: () {},
                        title: "Favourites",
                        gradient: const LinearGradient(
                          colors: [
                            ColorManager.kGradientCyan,
                            ColorManager.kGradientBlue,
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                        size: size,
                      ),
                      QuickAccessCard(
                        onTap: () {},
                        title: "Favourites",
                        gradient: const LinearGradient(
                          colors: [
                            ColorManager.kGradientPeach,
                            ColorManager.kGradientRose,
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                        size: size,
                      ),
                      QuickAccessCard(
                        onTap: () {},
                        title: "Favourites",
                        gradient: const LinearGradient(
                          colors: [
                            ColorManager.kGradientIndigo,
                            ColorManager.kGradientVoilet,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                        ),
                        size: size,
                      ),
                      QuickAccessCard(
                        onTap: () {},
                        title: "Favourites",
                        gradient: const LinearGradient(
                          colors: [
                            ColorManager.kGradientGreen,
                            ColorManager.kGradientGreenLight,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                        ),
                        size: size,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}

class QuickAccessCard extends StatelessWidget {
  final Function onTap;
  final String title;

  final Gradient gradient;
  final Size size;
  const QuickAccessCard(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.gradient,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120, // size.height * .22, //160,
      margin: const EdgeInsets.only(top: 10, left: 10),
      width: size.width * .18, //170,//200//.45
      decoration: BoxDecoration(
        gradient: gradient,
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: const [
          BoxShadow(
            color: ColorManager.boxShadowColor,
            blurRadius: 6,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                ),
                height: 60, // size.height * 0.1, //60,
                width: 80, //size.width * 0.15, //80,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0X00000029),
                      blurRadius: 6,
                      offset: Offset(0, 1),
                    ),
                  ],
                  shape: BoxShape.circle,
                  color: Colors.white24,
                ),
                child: WebsafeSvg.asset(
                  ImageAssets.consultingIcon,
                  fit: BoxFit.none,
                ),
              ),
              const SizedBox(height: 10 // size.height * 0.01, // 10,
                  ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontFamily: FontConstants.fontFamily,
                      fontSize: FontSize.s15,
                      letterSpacing: 0.23,
                      color: Colors.white,
                      fontWeight: FontWeightManager.semiBold),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            left: 100,
            // alignment: Alignment.topRight,
            child: Container(
              height: 150, //size.height * 0.21, //150,
              width: 150, //size.width * 0.4, // 150,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0X00000029),
                    blurRadius: 6,
                    offset: Offset(0, 1),
                  ),
                ],
                shape: BoxShape.circle,
                color: Colors.white24,
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 70,
            // bottom: 0,
            // alignment: Alignment.bottomRight,
            child: Container(
              height: 150, //size.height * 0.2, //150,
              width: 150, //size.width * 0.45, // 150,

              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0X00000029),
                    blurRadius: 6,
                    offset: Offset(0, 1),
                  ),
                ],
                shape: BoxShape.circle,
                color: Colors.white24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
