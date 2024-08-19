// lib/services/revenue_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/revenue_item.dart';

class RevenueService {
  /// Lấy dữ liệu doanh thu từ API
  /// Returns một [Future] chứa [List] của [RevenueItem].
  /// Throws [Exception] nếu không thể tải dữ liệu.
  Future<List<RevenueItem>> fetchRevenueData() async {
    // final response = await http.get(Uri.parse('http://localhost:3000/'));

    // if (response.statusCode == 200) {
    //   final jsonResponse = json.decode(response.body);
    //   final obdata = json.decode(jsonResponse['body'])['obdata'];
    //   final dsdoanhthu = json.decode(obdata)['dsdoanhthu'];
    //   final List<dynamic> revenueList = json.decode(dsdoanhthu);

    //   // Chuyển đổi JSON thành danh sách RevenueItem
    //   return revenueList.map((item) => RevenueItem.fromJson(item)).toList();
    // } else {
    //   throw Exception('Failed to load revenue data');
    // }

    final response = await http.get(Uri.parse('http://localhost:3000/obdata'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      final List<dynamic> dsluotdichvu = jsonResponse['dsluotdichvu'];

      // Chuyển đổi JSON thành danh sách RevenueItem
      return dsluotdichvu.map((item) => RevenueItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load revenue data');
    }
  }
}
