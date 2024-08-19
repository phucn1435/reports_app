import 'package:untitled/models/chart_style_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/revenue_item.dart';
import '../widgets/line_chart_widget.dart';

class RevenueDetailScreen extends StatelessWidget {
  final RevenueItem revenueItem;
  final DateTime fromDate;
  final DateTime toDate;

  const RevenueDetailScreen({
    Key? key,
    required this.revenueItem,
    required this.fromDate,
    required this.toDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final displayFormat = DateFormat('dd/MM/yyyy');

    // Lọc dữ liệu dựa trên khoảng thời gian
    final filteredDetails = revenueItem.details.where((detail) {
      final detailDate = dateFormat.parse(detail.date);
      return (detailDate.isAfter(fromDate) ||
              detailDate.isAtSameMomentAs(fromDate)) &&
          (detailDate.isBefore(toDate) || detailDate.isAtSameMomentAs(toDate));
    }).toList();

    // Sắp xếp dữ liệu theo ngày
    filteredDetails.sort(
        (a, b) => dateFormat.parse(a.date).compareTo(dateFormat.parse(b.date)));

    // final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Biểu đồ doanh thu',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: 'Biểu đồ doanh thu - ',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: revenueItem.title,
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                '${displayFormat.format(fromDate)} - ${displayFormat.format(toDate)}',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: filteredDetails.isEmpty
                  ? Center(
                      child: Text(
                        'Không có dữ liệu',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    )
                  : RevenueLineChart(
                      filteredDetails: filteredDetails,
                      objectStyle:
                          ChartStyle(interval: 2, axisNameChart: 'Doanh thu'),
                    ),
            ),
            // _buildLegend()
          ],
        ),
      ),
    );
  }
}
