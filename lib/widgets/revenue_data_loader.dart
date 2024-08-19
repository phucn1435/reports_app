import 'package:flutter/material.dart';
import '../models/revenue_item.dart';
import '../services/revenue_service.dart';

class RevenueDataLoader {
  final RevenueService _revenueService = RevenueService();

  Future<List<RevenueItem>> fetchAndProcessRevenueData(
      DateTime? fromDate, DateTime? toDate) async {
    try {
      final List<RevenueItem> items = await _revenueService.fetchRevenueData();

      if (fromDate == null || toDate == null) {
        return items; // Return original items if no date range selected
      }

      for (var item in items) {
        double totalValue = item.details.where((detail) {
          final date = DateTime.parse(detail.date);
          return date.isAtSameMomentAs(fromDate) ||
              date.isAtSameMomentAs(toDate) ||
              (date.isAfter(fromDate) && date.isBefore(toDate));
        }).fold(0.0, (sum, detail) => sum + detail.value.toDouble());

        item.value = totalValue; // Update value
      }

      return items;
    } catch (e) {
      // Handle errors appropriately, e.g., logging or showing an error message
      print('Error fetching and processing data: $e');
      return []; // Return an empty list or handle according to your needs
    }
  }
}
