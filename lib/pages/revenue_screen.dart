import 'package:flutter/material.dart';
import '../models/revenue_item.dart';
import '../models/main_model.dart';
import '../widgets/revenue_card.dart';
import '../widgets/dialog_show_pickerDate.dart';
import '../widgets/filter_buttons.dart';
import '../widgets/revenue_data_loader.dart';

class RevenueScreen extends StatefulWidget {
  @override
  _RevenueScreenState createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {
  late Future<List<RevenueItem>> _revenueItems;
  DateTime? _fromDate;
  DateTime? _toDate;
  RevenueItem? _selectedItem; // Thêm thuộc tính để theo dõi item được chọn
  @override
  void initState() {
    super.initState();
    _revenueItems = _loadRevenueData(); // Fetch data on init
  }

  Future<List<RevenueItem>> _loadRevenueData() async {
    final loader = RevenueDataLoader();
    return await loader.fetchAndProcessRevenueData(_fromDate, _toDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<RevenueItem>>(
        future: _revenueItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoading();
          } else if (snapshot.hasError) {
            return _buildError(snapshot.error);
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildEmptyData();
          } else {
            return _buildMainContent(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildError(Object? error) {
    return Center(child: Text('Error: $error'));
  }

  Widget _buildEmptyData() {
    return Center(child: Text('No data available'));
  }

  Widget _buildMainContent(List<RevenueItem> data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FilterButtons(
                fromDate: _fromDate,
                toDate: _toDate,
                onDateRangeSelected: () async {
                  await _showDateRangeDialog();
                  setState(() {
                    _revenueItems = _loadRevenueData();
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MainModel.gridColumns,
                childAspectRatio: MainModel.itemAspectRatio,
                crossAxisSpacing: MainModel.gridSpacing,
                mainAxisSpacing: MainModel.gridSpacing,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return RevenueCard(
                  item: data[index],
                  isSelected:
                      _selectedItem == data[index], // Truyền trạng thái chọn
                  onSelect: () {
                    setState(() {
                      _selectedItem = data[index];
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDateRangeDialog() async {
    final fromDateController = TextEditingController();
    final toDateController = TextEditingController();

    final picked = await showDateRangeSelectionDialog(
      context,
      fromDateController,
      toDateController,
      (pickedDate) => _fromDate = pickedDate,
      (pickedDate) => _toDate = pickedDate,
    );

    if (picked != null) {
      // print(fromDateController.text);
      setState(() {
        _fromDate = picked.start;
        _toDate = picked.end;
        _revenueItems = _loadRevenueData();
      });
    }
  }
}
