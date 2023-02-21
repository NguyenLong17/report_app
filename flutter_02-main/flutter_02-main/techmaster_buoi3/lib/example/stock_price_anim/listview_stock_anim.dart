import 'dart:math';

import 'package:flutter/material.dart';
import 'package:techmaster_buoi3/demo/animation_list.dart';
import 'package:techmaster_buoi3/example/stock_price/listview_stock.dart';
import 'package:techmaster_buoi3/example/stock_price_anim/stock_item_anim.dart';

class ListStockPriceAnim extends StatefulWidget {
  const ListStockPriceAnim({Key? key}) : super(key: key);

  @override
  State<ListStockPriceAnim> createState() => _ListStockPriceAnimState();
}

class _ListStockPriceAnimState extends State<ListStockPriceAnim> {
  List<StockPriceModel> listStockModel = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late ListModel<StockPriceModel> _list;
  StockPriceModel? _selectedItem;

  @override
  void initState() {
    listStockModel = mockStockPrice(5);
    _list = ListModel<StockPriceModel>(
      listKey: _listKey,
      items: listStockModel,
      removedItemBuilder: _buildRemovedItem,
    );
    super.initState();
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return StockItemAnim(
      model: listStockModel[index],
      index: index,
      animation: animation,
      selected: listStockModel[index].code == _selectedItem?.code,
      onTap: (item){
        setState(() {
          _selectedItem = item;
        });
      },
    );
  }

  Widget _buildRemovedItem(StockPriceModel model, BuildContext context,
      Animation<double> animation) {
    return StockItemAnim(
      animation: animation,
      model: model,
      index: 0,

    );
  }

  // Insert the "next item" into the list model.
  void _insert() {
    final int index =
        _selectedItem == null ? _list.length : _list.indexOf(_selectedItem!);
    final randomModel = _getAValueRandom(_list.items);
    if (randomModel != null) {
      _list.insert(index, randomModel);
    } else {
      print('Vui long thu lai');
    }
  }

  // Remove the selected item from the list model.
  void _remove() {
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(_selectedItem!));
      setState(() {
        _selectedItem = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Price'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: _insert,
            tooltip: 'insert a new item',
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle),
            onPressed: _remove,
            tooltip: 'remove the selected item',
          ),
        ],
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _list.length,
        itemBuilder: _buildItem,
      ),
    );
  }
}

StockPriceModel? _getAValueRandom(List<StockPriceModel> currentList) {
  var randomValue = Random().nextInt(20);
  int countLoop = 0;
  while (countLoop < 1000) {
    final model = StockPriceModel(
      code: getRandomStockCode(),
      stockPrice: randomValue * 4,
      marginPercent: (randomValue % 2 == 0 ? 1 : -1) * randomValue * 0.01,
      total: randomValue % 3 == 0 ? null : randomValue * 1000,
    );
    countLoop++;
    if (!currentList.contains(model)) {
      return model;
    }
  }
  return null;
}
