import 'package:flutter/material.dart';
import 'fruitItem.dart';
import 'fruitclass.dart';

class FruitList extends StatelessWidget {
  final List<Fruit> items;

  FruitList({required Key key, required this.items});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return FruitItem(item: items[index]);
      },
    );
  }
}
