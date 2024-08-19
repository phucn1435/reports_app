import 'package:flutter/material.dart';
import 'pages/reports_page.dart';
import 'pages/revenue_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ReportsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: RevenueDetailScreen(),
//     );
//   }
// }

// class RevenueDetailScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Dữ liệu ví dụ cho biểu đồ
//     final List<FlSpot> spots = List.generate(
//       50,
//       (index) => FlSpot(index.toDouble(), (index % 10).toDouble()),
//     );

//     return Scaffold(
//       appBar: AppBar(title: Text('Chi tiết doanh thu')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text('Biểu đồ doanh thu'),
//             SizedBox(height: 20),
//             ScrollableLineChart(spots: spots),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ScrollableLineChart extends StatelessWidget {
//   final List<FlSpot> spots;

//   ScrollableLineChart({required this.spots});

//   @override
//   Widget build(BuildContext context) {
//     // Chiều rộng tối đa của biểu đồ dựa trên số lượng điểm dữ liệu
//     final double chartWidth = spots.length * 40.0; // Điều chỉnh nếu cần

//     return Container(
//       width: double.infinity,
//       height: 300,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.black, // Màu của viền
//           width: 2, // Độ dày của viền
//         ),
//         borderRadius: BorderRadius.circular(8.0), // Góc viền bo tròn nếu muốn
//       ),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Container(
//           width: chartWidth,
//           child: LineChart(
//             LineChartData(
//               gridData: FlGridData(show: false),
//               // titlesData: FlTitlesData(
//               //   leftTitles: SideTitles(
//               //     showTitles: true,
//               //     reservedSize: 40,
//               //     margin: 8,
//               //   ),
//               //   bottomTitles: SideTitles(
//               //     showTitles: true,
//               //     reservedSize: 40,
//               //     margin: 8,
//               //   ),
//               // ),
//               borderData: FlBorderData(
//                 show: true,
//                 border: Border.all(
//                   color: const Color(0xff37434d),
//                   width: 1,
//                 ),
//               ),
//               lineBarsData: [
//                 LineChartBarData(
//                   spots: spots,
//                   isCurved: true,
//                   color: Colors.blue,
//                   dotData: FlDotData(show: false),
//                   belowBarData: BarAreaData(show: false),
//                 ),
//               ],
//               minX: 0,
//               maxX: (spots.length - 1).toDouble(),
//               minY: 0,
//               maxY: 10, // Đặt giá trị maxY đủ lớn để hiển thị các điểm dữ liệu
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
