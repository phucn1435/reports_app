// lib/models/main_model.dart
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class MainModel {
  // Định dạng tiền tệ cho Việt Nam
  static final currencyFormat = NumberFormat('#,##0.00', 'vi_VN');

// Cấu hình GridView
  static int gridColumns = 2; // Số cột trong GridView
  static double minItemWidth =
      150; // Chiều rộng tối thiểu cho mỗi item trong grid
  static double itemAspectRatio =
      2 / 1.3; // Tỷ lệ chiều rộng/chiều cao của mỗi item
  static double gridPadding = 8; // Padding xung quanh GridView
  static double gridSpacing = 10; // Khoảng cách giữa các item trong GridView

  // Cấu hình Card
  static Color cardColor = Color.fromRGBO(11, 37, 62, 1.0); // Màu nền của card
  static double cardPadding = 8; // Padding bên trong card
  static double cardSpacing = 8; // Khoảng cách giữa các phần tử trong card

  // Kiểu chữ
  static TextStyle titleStyle = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.white); // Kiểu chữ cho tiêu đề
  static TextStyle valueStyle = const TextStyle(
      color: Color.fromRGBO(218, 231, 71, 1.0),
      fontWeight: FontWeight.bold); // Kiểu chữ cho giá trị
}
