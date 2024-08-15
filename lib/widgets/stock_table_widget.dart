import 'package:flutter/material.dart';
import '../models/stock_model.dart';

class StockTableWidget extends StatelessWidget {
  final List<Stock> stocks;

  const StockTableWidget({required this.stocks});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Ticker')),
          DataColumn(label: Text('Open')),
          DataColumn(label: Text('Close')),
          DataColumn(label: Text('High')),
          DataColumn(label: Text('Low')),
          DataColumn(label: Text('Volume')),
          DataColumn(label: Text('Date')),
        ],
        rows: List<DataRow>.generate(stocks.length, (index) {
          final stock = stocks[index];
          // Define alternate row colors
          final isEvenRow = index.isEven;
          return DataRow(
            color: MaterialStateProperty.all(isEvenRow ? Colors.grey[200] : Colors.white),
            cells: [
              DataCell(Text(stock.ticker)),
              DataCell(Text(stock.open.toString())),
              DataCell(Text(stock.close.toString())),
              DataCell(Text(stock.high.toString())),
              DataCell(Text(stock.low.toString())),
              DataCell(Text(stock.vol.toString())),
              DataCell(Text(stock.date)),
            ],
          );
        }),
      ),
    );
  }
}
