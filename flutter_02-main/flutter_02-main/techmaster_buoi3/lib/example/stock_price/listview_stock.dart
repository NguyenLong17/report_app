import 'dart:math';
import 'package:flutter/material.dart';
import 'package:techmaster_buoi3/example/stock_price/stock_item.dart';

class ListStockPrice extends StatefulWidget {
  const ListStockPrice({Key? key}) : super(key: key);

  @override
  State<ListStockPrice> createState() => _ListStockPriceState();
}

class _ListStockPriceState extends State<ListStockPrice> {
  List<StockPriceModel> listStockModel = [];

  @override
  void initState() {
    listStockModel = mockStockPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Price'),
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          return StockItem(
            model: listStockModel[index],
            index: index,
          );
        },
        itemCount: listStockModel.length,
      ),
    );
  }
}

List<StockPriceModel> mockStockPrice([int? numberItem]) {
  List<StockPriceModel> listStockPrice = [];
  Random random = Random();
  for (int i = 0; i < (numberItem ?? 100); i++) {
    var randomValue = random.nextInt(20);
    final model = StockPriceModel(
      code: getRandomStockCode(),
      stockPrice: randomValue * 4,
      marginPercent: (randomValue % 2 == 0 ? 1 : -1) * randomValue * 0.01,
      total: randomValue % 3 == 0 ? null : randomValue * 1000,
    );
    if (!listStockPrice.contains(model)) {
      listStockPrice.add(model);
    }
  }
  return listStockPrice;
}

String getRandomStockCode() {
  Random random = Random();
  List<String> character = ['A', 'B', 'C', 'D', 'E', 'F', 'J', 'H', 'G', 'X'];
  return '${character[random.nextInt(10)]}'
      '${character[random.nextInt(10)]}'
      '${character[random.nextInt(10)]}';
}

class StockPriceModel {
  String? code;
  double? stockPrice;
  double? marginPercent;
  double? total;

  StockPriceModel({
    this.code,
    this.stockPrice,
    this.marginPercent,
    this.total,
  });

  @override
  bool operator ==(Object other) {
    return other.runtimeType == StockPriceModel &&
        (other as StockPriceModel).code == this.code;
  }
}
