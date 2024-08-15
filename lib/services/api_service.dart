import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/stock_model.dart';

class ApiService {
  final String apiUrl = "https://datastock.onrender.com/data";
  Timer? timer;
  StreamController<List<Stock>> _stockController = StreamController<List<Stock>>.broadcast();

  Stream<List<Stock>> get stockStream => _stockController.stream;

  void startPolling() {
    timer = Timer.periodic(Duration(seconds: 10), (_) async {
      await fetchStockData();
    });
  }

  Future<void> fetchStockData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> stockData = jsonResponse['TotalTradeRealReply']['stockTotalReals'];
        final List<Stock> stocks = stockData.map((json) => Stock.fromJson(json)).toList();

        _stockController.add(stocks);
      } else {
        throw Exception('Failed to load stock data');
      }
    } catch (e) {
      print('Fetch Error: $e');
    }
  }

  void dispose() {
    timer?.cancel();
    _stockController.close();
  }
}
