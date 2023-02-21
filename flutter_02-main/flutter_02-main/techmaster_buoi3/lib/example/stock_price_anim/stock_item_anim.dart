import 'package:flutter/material.dart';
import 'package:techmaster_buoi3/example/stock_price/listview_stock.dart';

class StockItemAnim extends StatelessWidget {
  final StockPriceModel model;
  final int index;
  final Animation<double> animation;
  final Function(StockPriceModel model)? onTap;
  final bool selected;

  const StockItemAnim({
    Key? key,
    required this.model,
    required this.index,
    required this.animation,
    this.selected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool priceUp = (model.marginPercent ?? 0) > 0;
    Color theme = priceUp ? Colors.green : Colors.red;
    return SizeTransition(
      sizeFactor: animation,
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap!(model);
          }
        },
        behavior: HitTestBehavior.opaque,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: selected
                ? Colors.yellow
                : (index % 2 == 0
                    ? Color(0xff322F2E)
                    : Color(0xff322F2E).withOpacity(0.8)),
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
        ),
      ),
    );
  }
}
