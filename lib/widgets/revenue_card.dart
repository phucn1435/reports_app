import 'package:flutter/material.dart';
import '../models/revenue_item.dart';
import '../models/main_model.dart';
import '../widgets/dialog_show_pickerDate.dart';
import '../pages/revenue_detail_screen.dart';
import 'dialog_type.dart';

class RevenueCard extends StatelessWidget {
  final RevenueItem item;
  final bool isSelected; // Thêm thuộc tính isSelected
  final VoidCallback onSelect; // Thêm thuộc tính onSelect

  const RevenueCard({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelect(); // Gọi callback khi thẻ được chọn
        _showDateRangeDialog(context, item);
      },
      child: Card(
        color: isSelected ? Colors.blue : MainModel.cardColor,
        child: Padding(
          padding: EdgeInsets.all(MainModel.cardPadding),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTitle(),
                SizedBox(height: MainModel.cardSpacing),
                _buildValue(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      item.title,
      style: MainModel.titleStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildValue() {
    return Text(
      MainModel.currencyFormat.format(item.value),
      style: MainModel.valueStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }

  Future<void> _showDateRangeDialog(
      BuildContext context, RevenueItem item) async {
    DateTime? fromDate;
    DateTime? toDate;

    final fromDateController = TextEditingController();
    final toDateController = TextEditingController();

    final picked = await showDateRangeSelectionDialog(
      context,
      fromDateController,
      toDateController,
      (pickedDate) => fromDate = pickedDate,
      (pickedDate) => toDate = pickedDate,
    );

    if (picked != null) {
      fromDate = picked.start;
      toDate = picked.end;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RevenueDetailScreen(
            revenueItem: item,
            fromDate: fromDate!,
            toDate: toDate!,
          ),
        ),
      );
    }
  }
}
