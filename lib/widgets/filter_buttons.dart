import 'package:flutter/material.dart';

class FilterButtons extends StatelessWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  final VoidCallback onDateRangeSelected;

  const FilterButtons({
    Key? key,
    this.fromDate,
    this.toDate,
    required this.onDateRangeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = Colors.white.withOpacity(0.6);
    final Color textColor = Colors.black87;

    return Container(
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onDateRangeSelected,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: textColor, size: 16),
                  SizedBox(width: 4),
                  Text(
                    fromDate != null && toDate != null
                        ? '${_formatDate(fromDate!)} - ${_formatDate(toDate!)}'
                        : 'Tháng này',
                    style: TextStyle(color: textColor, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
            ),
            child: Icon(Icons.filter_list, color: Colors.white),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
