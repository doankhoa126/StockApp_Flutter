import 'package:flutter/material.dart';
import '../models/stock_model.dart';
import '../services/api_service.dart';
import '../widgets/stock_table_widget.dart';

class HighestVolumeScreen extends StatefulWidget {
  @override
  _HighestVolumeScreenState createState() => _HighestVolumeScreenState();
}

class _HighestVolumeScreenState extends State<HighestVolumeScreen> {
  final ApiService apiService = ApiService();
  List<Stock> stocks = [];

  @override
  void initState() {
    super.initState();
    apiService.startPolling(); // Start polling to fetch data
    apiService.stockStream.listen((data) {
      data.sort((a, b) => b.vol.compareTo(a.vol));
      if (mounted) {
        setState(() {
          stocks = data;
        });
      }
    });
  }

  @override
  void dispose() {
    apiService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Highest Volume Stocks')),
      body: stocks.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: StockTableWidget(stocks: stocks),
            ),
    );
  }
}
