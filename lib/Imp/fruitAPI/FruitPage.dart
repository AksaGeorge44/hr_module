import 'package:flutter/material.dart';
import 'fruitItem.dart';
import 'fruitList.dart';
import 'fruitclass.dart';

class FruitPage extends StatelessWidget {
  final String title;
  final Future<List<Fruit>> products;

  FruitPage({required Key key, required this.title, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF4CAF50),
          title: Text("GeeksForGeeks"),
        ),
        body: Center(
          child: FutureBuilder<List<Fruit>>(
            future: products,
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? FruitList(items: snapshot.data!, key: Key("value"),)
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
