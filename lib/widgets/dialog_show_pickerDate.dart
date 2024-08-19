import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dialog_type.dart';

/// Hiển thị hộp thoại chọn khoảng thời gian
Future<DateTimeRange?> showDateRangeSelectionDialog(
  BuildContext context,
  TextEditingController fromDateController,
  TextEditingController toDateController,
  Function(DateTime) updateFromDate,
  Function(DateTime) updateToDate,
) {
  return showDialog<DateTimeRange>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogTitle(),
              SizedBox(height: 16.0),
              _buildDatePicker(
                context,
                'Từ ngày',
                fromDateController,
                updateFromDate,
              ),
              _buildDatePicker(
                context,
                'Đến ngày',
                toDateController,
                updateToDate,
              ),
              SizedBox(height: 24.0),
              _buildDialogActions(
                  context, fromDateController, toDateController),
            ],
          ),
        ),
      );
    },
  );
}

/// Xây dựng tiêu đề của hộp thoại
Widget _buildDialogTitle() {
  return Text(
    'Chọn khoảng thời gian',
    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
  );
}

/// Xây dựng các hành động của hộp thoại
Widget _buildDialogActions(
  BuildContext context,
  TextEditingController fromDateController,
  TextEditingController toDateController,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      TextButton(
        child: Text('Hủy'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: Text('Tìm kiếm'),
        onPressed: () {
          _handleSearch(context, fromDateController, toDateController);
        },
      ),
    ],
  );
}

/// Xử lý hành động tìm kiếm và kiểm tra dữ liệu nhập vào
void _handleSearch(
  BuildContext context,
  TextEditingController fromDateController,
  TextEditingController toDateController,
) {
  if (fromDateController.text.isEmpty || toDateController.text.isEmpty) {
    showTypeDialog(
      context,
      'Vui lòng chọn cả "Từ ngày" và "Đến ngày".',
      DialogType.error,
    );
  } else {
    final fromDate = DateFormat('yyyy-MM-dd').parse(fromDateController.text);
    final toDate = DateFormat('yyyy-MM-dd').parse(toDateController.text);

    if (fromDate.isAfter(toDate)) {
      showTypeDialog(
        context,
        '"Từ ngày" phải nhỏ hơn hoặc bằng "Đến ngày".',
        DialogType.error,
      );
    } else {
      Navigator.of(context).pop(DateTimeRange(start: fromDate, end: toDate));
    }
  }
}

/// Xây dựng widget chọn ngày
Widget _buildDatePicker(
  BuildContext context,
  String hintText,
  TextEditingController controller,
  Function(DateTime) onDatePicked,
) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintText: hintText,
      ),
      onTap: () async {
        final pickedDate = await _selectDate(context, controller.text);
        if (pickedDate != null) {
          onDatePicked(pickedDate);
          controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        }
      },
    ),
  );
}

/// Hiển thị hộp thoại chọn ngày
Future<DateTime?> _selectDate(BuildContext context, String initialDate) async {
  final initialDateTime = initialDate.isNotEmpty
      ? DateFormat('yyyy-MM-dd').parse(initialDate)
      : DateTime.now();
  return showDatePicker(
    context: context,
    initialDate: initialDateTime,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
}
