import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/revenue_item.dart';
import '../models/chart_style_model.dart';
import '../models/main_model.dart';

class RevenueLineChart extends StatelessWidget {
  final List<RevenueDetail> filteredDetails;
  final ChartStyle? objectStyle;
  late final ChartStyle _chartStyle;

  RevenueLineChart({
    Key? key,
    required this.filteredDetails,
    this.objectStyle,
  }) : super(key: key) {
    _chartStyle = ChartStyle.fromStyle(objectStyle ?? ChartStyle());
  }

  @override
  Widget build(BuildContext context) {
    final spots = _generateSpots();
    final maxYValue = _calculateMaxYValue();

    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red, // Màu của viền
              width: 2, // Độ dày của viền
            ),
            borderRadius:
                BorderRadius.circular(8.0), // Góc viền bo tròn nếu muốn
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: _calculateChartWidth(),
              height: _chartStyle.heightChart,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    _buildLineChart(spots, maxYValue),
                    ...spots
                        .map((spot) => _buildDotWidget(spot, maxYValue))
                        .toList(),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Uncomment if you have a legend
        _buildLegend(),
      ],
    );
  }

  List<FlSpot> _generateSpots() {
    return filteredDetails.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.value / 1000000);
    }).toList();
  }

  double _calculateMaxYValue() {
    final maxY = filteredDetails
        .map((e) => e.value / 1000000)
        .reduce((a, b) => a > b ? a : b);
    return (maxY * 1.1).ceilToDouble();
  }

  double _calculateChartWidth() {
    return (filteredDetails.length + 2) * 100.0;
  }

  LineChart _buildLineChart(List<FlSpot> spots, double maxYValue) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 0.5,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey[300],
            strokeWidth: 1,
          ),
          getDrawingVerticalLine: (value) => FlLine(
            color: Colors.grey[300],
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < filteredDetails.length) {
                  final date = DateFormat('dd-MM').format(
                      DateFormat('yyyy-MM-dd')
                          .parse(filteredDetails[index].date));
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Text(date, style: const TextStyle(fontSize: 10)),
                    ),
                  );
                }
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: const Text(''),
                );
              },
              interval: 1,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: (value, meta) {
                final text = value == 0 ? '0' : '${value.toInt()} Tr';
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(text, style: const TextStyle(fontSize: 10)),
                  ),
                );
              },
              interval: _chartStyle.interval,
            ),
            axisNameWidget: RotatedBox(
              quarterTurns: 4,
              child: Text(
                _chartStyle.axisNameChart,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            axisNameSize: 16,
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1),
        ),
        minX: -1,
        maxX: filteredDetails.length.toDouble(),
        minY: 0,
        maxY: maxYValue,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: false,
            color: _chartStyle.colorLineChart,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, bar, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: _chartStyle.colorDot,
                  strokeWidth: 1,
                );
              },
            ),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        lineTouchData: LineTouchData(enabled: false),
      ),
    );
  }

  Widget _buildDotWidget(FlSpot spot, double maxY) {
    final index = spot.x.toInt();
    final value = filteredDetails[index].value / 1000000;

    return Positioned(
      top: (1 - spot.y / maxY) * (_chartStyle.heightChart - 60),
      left: (spot.x + 1) * 100 + 40,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          '${MainModel.currencyFormat.format(value)} Tr',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Đường thẳng màu cyan
          Container(
            width: 16,
            height: 2,
            color: Colors.cyan,
          ),
          // Hình tròn màu cyan
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.cyan,
              shape: BoxShape.circle,
            ),
          ),
          // Đường thẳng màu cyan
          Container(
            width: 16,
            height: 2,
            color: Colors.cyan,
          ),
          SizedBox(width: 8),
          // Văn bản chú giải
          Text(
            'Doanh thu',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
