import 'package:flutter/material.dart';
import 'package:techmaster_buoi3/demo/animation_list.dart';
import 'package:techmaster_buoi3/demo/demo_gridview.dart';
import 'package:techmaster_buoi3/demo/list_whell_scroll_view.dart';
import 'package:techmaster_buoi3/demo/listview.dart';
import 'package:techmaster_buoi3/demo/listview_builder.dart';
import 'package:techmaster_buoi3/demo/reorderable_listview.dart';
import 'package:techmaster_buoi3/demo_load_more/load_more_by_hand.dart';
import 'package:techmaster_buoi3/example/list_category/list_category.dart';
import 'package:techmaster_buoi3/example/stock_price/listview_stock.dart';
import 'package:techmaster_buoi3/example/stock_price_anim/listview_stock_anim.dart';

void main() {
  runApp(const MaterialApp(
    home: ListStockPriceAnim(),
  ));
}
