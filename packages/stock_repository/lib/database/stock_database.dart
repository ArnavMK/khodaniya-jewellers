import '../models/models.dart';
import '../constants/costants.dart';

abstract class StockRepository {
  Iterable<Item> getAllStocks();
  void initialize();
}

class LocalStockDatabase implements StockRepository {
  Iterable<Item> _stock = [];

  LocalStockDatabase._privateConstructor();
  static final LocalStockDatabase _instance = LocalStockDatabase._privateConstructor();
  static LocalStockDatabase get instance {
    return _instance;
  }
  
  @override
  Iterable<Item> getAllStocks() { 
    return _stock;
  }

  @override
  void initialize() {

    // Fetch data from go backend
    // convert the Iterable<Map<String, dynamic>> to Iterable<Item>
    // set that to _stock

    _stock = items;

    print(_stock.toString());
  }
}
