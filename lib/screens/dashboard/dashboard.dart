import 'package:fl_chart/fl_chart.dart';
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
  TotalSales? totalSales;
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
            totalSales = dashBoardModelData!.totalSales;
          });
        } else {}
      });
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
                        "Today's Sales ",
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
                        _buildSalesCard("Count", ColorManager.kPrimaryColor),
                        _buildSalesCard("Amount", ColorManager.kMagentha),
                        _buildSalesCard("Customers", ColorManager.kOrange),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 260,
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
                                  height: 200,
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
                                      Expanded(
                                        child: LineChart(
                                          LineChartData(
                                            gridData: FlGridData(show: false),
                                            titlesData: FlTitlesData(
                                              leftTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                      showTitles: false)),
                                              topTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                      showTitles: false)),
                                              rightTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                      showTitles: false)),
                                              bottomTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                  showTitles: true,
                                                  getTitlesWidget:
                                                      (value, meta) {
                                                    const titles = [
                                                      'Mon',
                                                      'Tue',
                                                      'Wed',
                                                      'Thu',
                                                      'Fri',
                                                      'Sat',
                                                      'Sun'
                                                    ];
                                                    if (value.toInt() <
                                                        titles.length) {
                                                      return Text(titles[
                                                          value.toInt()]);
                                                    }
                                                    return const Text('');
                                                  },
                                                ),
                                              ),
                                            ),
                                            borderData:
                                                FlBorderData(show: false),
                                            minX: 0,
                                            maxX: 6,
                                            minY: 0,
                                            maxY: 6,
                                            lineBarsData: [
                                              LineChartBarData(
                                                spots: [
                                                  FlSpot(0, 3),
                                                  FlSpot(1, 1),
                                                  FlSpot(2, 4),
                                                  FlSpot(3, 2),
                                                  FlSpot(4, 5),
                                                  FlSpot(5, 1),
                                                  FlSpot(6, 4),
                                                ],
                                                isCurved: true,
                                                color:
                                                    ColorManager.kPrimaryColor,
                                                barWidth: 3,
                                                isStrokeCapRound: true,
                                                dotData: FlDotData(show: false),
                                                belowBarData:
                                                    BarAreaData(show: false),
                                              ),
                                            ],
                                          ),
                                        ),
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
                                  height: 200,
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
                                      Expanded(
                                        child: BarChart(
                                          BarChartData(
                                            alignment:
                                                BarChartAlignment.spaceAround,
                                            maxY: 20,
                                            barTouchData: BarTouchData(
                                              enabled: false,
                                              touchTooltipData:
                                                  BarTouchTooltipData(
                                                // getTooltipColor:
                                                //     Colors.transparent,
                                                tooltipPadding: EdgeInsets.zero,
                                                tooltipMargin: 8,
                                                getTooltipItem: (
                                                  BarChartGroupData group,
                                                  int groupIndex,
                                                  BarChartRodData rod,
                                                  int rodIndex,
                                                ) {
                                                  return BarTooltipItem(
                                                    rod.toY.round().toString(),
                                                    const TextStyle(
                                                      color: ColorManager
                                                          .kPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            titlesData: FlTitlesData(
                                              show: true,
                                              bottomTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                  showTitles: true,
                                                  reservedSize: 30,
                                                  getTitlesWidget: getTitles,
                                                ),
                                              ),
                                              leftTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false),
                                              ),
                                              topTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false),
                                              ),
                                              rightTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false),
                                              ),
                                            ),
                                            borderData: FlBorderData(
                                              show: false,
                                            ),
                                            barGroups: [
                                              BarChartGroupData(
                                                x: 0,
                                                barRods: [
                                                  BarChartRodData(
                                                      toY: 8,
                                                      color: ColorManager
                                                          .kPrimaryColor,
                                                      width: 16)
                                                ],
                                                showingTooltipIndicators: [0],
                                              ),
                                              BarChartGroupData(
                                                x: 1,
                                                barRods: [
                                                  BarChartRodData(
                                                      toY: 10,
                                                      color: ColorManager
                                                          .kPrimaryColor,
                                                      width: 16)
                                                ],
                                                showingTooltipIndicators: [0],
                                              ),
                                              BarChartGroupData(
                                                x: 2,
                                                barRods: [
                                                  BarChartRodData(
                                                      toY: 14,
                                                      color: ColorManager
                                                          .kPrimaryColor,
                                                      width: 16)
                                                ],
                                                showingTooltipIndicators: [0],
                                              ),
                                              BarChartGroupData(
                                                x: 3,
                                                barRods: [
                                                  BarChartRodData(
                                                      toY: 15,
                                                      color: ColorManager
                                                          .kPrimaryColor,
                                                      width: 16)
                                                ],
                                                showingTooltipIndicators: [0],
                                              ),
                                              BarChartGroupData(
                                                x: 4,
                                                barRods: [
                                                  BarChartRodData(
                                                      toY: 13,
                                                      color: ColorManager
                                                          .kPrimaryColor,
                                                      width: 16)
                                                ],
                                                showingTooltipIndicators: [0],
                                              ),
                                            ],
                                            gridData: FlGridData(show: false),
                                          ),
                                        ),
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

  Widget _buildSalesCard(String title, Color color) {
    return BuildBoxShadowContainer(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      height: 136,
      width: 240,
      circleRadius: 7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: const Icon(
              Icons.calculate_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _getSalesValue(title),
            style: buildCustomStyle(
              FontWeightManager.semiBold,
              FontSize.s20,
              0.38,
              ColorManager.textColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: buildCustomStyle(
                  FontWeightManager.medium,
                  FontSize.s15,
                  0.23,
                  ColorManager.textColor,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorManager.kGreenWithOpacity,
                    ),
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
                      ColorManager.kGreen,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getSalesValue(String title) {
    if (totalSales == null) return "0";

    PeriodStats? periodStats;
    switch (value) {
      case "today":
        periodStats = totalSales!.today;
        break;
      case "week":
        periodStats = totalSales!.week;
        break;
      case "month":
        periodStats = totalSales!.month;
        break;
      case "year":
        periodStats = totalSales!.year;
        break;
      default:
        return "0";
    }

    if (periodStats == null) return "0";

    switch (title) {
      case "Count":
        return periodStats.totalSales?.toString() ?? "0";
      case "Amount":
        return periodStats.totalAmount?.toString() ?? "0";
      case "Customers":
        return periodStats.totalCustomers?.toString() ?? "0";
      default:
        return "0";
    }
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 8,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('M', style: style);
        break;
      case 1:
        text = const Text('T', style: style);
        break;
      case 2:
        text = const Text('W', style: style);
        break;
      case 3:
        text = const Text('T', style: style);
        break;
      case 4:
        text = const Text('F', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4.0,
      child: text,
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
