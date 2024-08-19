import 'package:untitled/models/main_model.dart';

class RevenueDetail {
  final String date;
  final int value;

  RevenueDetail({required this.date, required this.value});

  factory RevenueDetail.fromJson(Map<String, dynamic> json) {
    return RevenueDetail(
        date: json['date'] ?? 'Unknown', value: json['value'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'date': date, 'value': value};
  }
}

class RevenueItem {
  final String title;
  double value;
  final List<RevenueDetail> details; // Thay đổi tên trường thành 'details'

  RevenueItem({
    required this.title,
    required this.value,
    required this.details, // Sử dụng loại dữ liệu mới
  });

  factory RevenueItem.fromJson(Map<String, dynamic> json) {
    return RevenueItem(
      title: json['title'] ?? 'Unknown',
      value: (json['value'] ?? 0).toDouble(),
      details: (json['details'] as List<dynamic>? ?? [])
          .map((item) => RevenueDetail.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'value': value,
      'details': details.map((detail) => detail.toJson()).toList(),
    };
  }
}
