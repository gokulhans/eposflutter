// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:pos_machine/resources/color_manager.dart';

// import 'line_titles.dart';

// class LineChartWidget extends StatelessWidget {
//   final List<Color> colorGradient = [
//     ColorManager.kPrimaryColor,
//     ColorManager.kPrimaryWithOpacity10,
//   ];
//   final Color color = ColorManager.kPrimaryColor;
//   LineChartWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         minX: 0,
//         maxX: 11,
//         minY: 0,
//         maxY: 6,
//         titlesData: LineTitles.getTitleData(),
//         gridData: FlGridData(
//           show: true,
//           getDrawingHorizontalLine: (value) {
//             return FlLine(
//               color: const Color(0xff37434d),
//               strokeWidth: 1,
//             );
//           },
//           drawVerticalLine: true,
//           getDrawingVerticalLine: (value) {
//             return FlLine(
//               color: const Color(0xff37434d),
//               strokeWidth: 1,
//             );
//           },
//         ),
//         borderData: FlBorderData(
//           show: true,
//           border: Border.all(color: const Color(0xff37434d), width: 1),
//         ),
//         lineBarsData: [
//           LineChartBarData(
//             spots: [
//               FlSpot(0, 3),
//               FlSpot(2.6, 2),
//               FlSpot(4.9, 5),
//               FlSpot(6.8, 2.5),
//               FlSpot(8, 4),
//               FlSpot(9.5, 3),
//               FlSpot(11, 4),
//             ],
//             isCurved: true,
//             color: color,
//             barWidth: 5,
//             // dotData: FlDotData(show: false),
//             belowBarData: BarAreaData(show: true, color: color
//                 // colorGradient
//                 //     .map((color) => color.withOpacity(0.3))
//                 //     .toList(),
//                 ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DataPoint {
//   final double x;
//   final double y;

//   DataPoint(this.x, this.y);
// }
