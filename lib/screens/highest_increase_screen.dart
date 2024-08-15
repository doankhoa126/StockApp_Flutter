import 'package:flutter/material.dart';
import '../models/stock_model.dart';
import '../services/api_service.dart';
import '../widgets/stock_table_widget.dart';

class HighestIncreaseScreen extends StatefulWidget {
  @override
  _HighestIncreaseScreenState createState() => _HighestIncreaseScreenState();
}

class _HighestIncreaseScreenState extends State<HighestIncreaseScreen> {
  final ApiService apiService = ApiService();
  List<Stock> stocks = [];

  @override
  void initState() {
    super.initState();
    apiService.startPolling(); // Start polling to fetch data
    apiService.stockStream.listen((data) {
      data.sort((a, b) {
        double aIncreasePercent = (a.close - a.open) / a.open * 100;
        double bIncreasePercent = (b.close - b.open) / b.open * 100;
        return bIncreasePercent.compareTo(aIncreasePercent);
      });

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
      appBar: AppBar(title: Text('Highest Increase Stocks')),
      body: stocks.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView( // Make the content scrollable
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: StockTableWidget(stocks: stocks),
              ),
            ),
    );
  }
}
