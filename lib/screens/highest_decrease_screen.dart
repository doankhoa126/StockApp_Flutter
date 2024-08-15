import 'package:flutter/material.dart';
import '../models/stock_model.dart';
import '../services/api_service.dart';
import '../widgets/stock_table_widget.dart';

class HighestDecreaseScreen extends StatefulWidget {
  @override
  _HighestDecreaseScreenState createState() => _HighestDecreaseScreenState();
}

class _HighestDecreaseScreenState extends State<HighestDecreaseScreen> {
  final ApiService apiService = ApiService();
  List<Stock> stocks = [];

  @override
  void initState() {
    super.initState();
    apiService.startPolling(); 
    apiService.stockStream.listen((data) {
      data.sort((a, b) {
        double aDecreasePercent = (a.open - a.close) / a.open * 100;
        double bDecreasePercent = (b.open - b.close) / b.open * 100;
        return bDecreasePercent.compareTo(aDecreasePercent);
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
      appBar: AppBar(title: Text('Highest Decrease Stocks')),
      
      body: stocks.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: StockTableWidget(stocks: stocks),
              ),
            ),
    );
  }
}
