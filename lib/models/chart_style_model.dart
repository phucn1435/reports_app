import 'package:flutter/material.dart';

class ChartStyle {
  final Color colorDot;
  final double widthColorDot;
  final Color mainColor;
  final Color colorLineChart;
  final double interval;
  final double heightChart;
  final String axisNameChart;

  // Constructor với giá trị mặc định
  ChartStyle(
      {this.colorDot = Colors.cyan, // Giá trị mặc định nếu không cung cấp
      this.widthColorDot = 4.0, // Giá trị mặc định nếu không cung cấp
      this.mainColor = Colors.blue, // Giá trị mặc định nếu không cung cấp
      this.colorLineChart = Colors.cyan,
      this.interval = 1.0,
      this.heightChart = 450,
      this.axisNameChart = ''});

  factory ChartStyle.fromStyle(ChartStyle style) {
    return ChartStyle(
        colorDot: style.colorDot,
        mainColor: style.mainColor,
        widthColorDot: style.widthColorDot,
        colorLineChart: style.colorLineChart,
        interval: style.interval,
        heightChart: style.heightChart,
        axisNameChart: style.axisNameChart);
  }
}
