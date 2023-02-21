import 'package:flutter/material.dart';
import 'package:techmaster_buoi3/example/stock_price/listview_stock.dart';

class StockItem extends StatelessWidget {
  final StockPriceModel model;
  final int index;
  const StockItem({
    Key? key,
    required this.model,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool priceUp = (model.marginPercent ?? 0) > 0;
    Color theme = priceUp ? Colors.green : Colors.red;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index % 2 == 0
            ? Color(0xff322F2E)
            : Color(0xff322F2E).withOpacity(0.8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                model.code ?? '',
                style: TextStyle(
                  color: theme,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '${model.stockPrice ?? ''}',
                style: TextStyle(
                  color: theme,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '${model.marginPercent ?? ''}',
                style: TextStyle(
                  color: theme,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '${model.total ?? ''}',
                style: TextStyle(
                  color: theme,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
