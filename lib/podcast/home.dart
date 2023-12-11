import 'package:flutter/material.dart';
import 'package:hr_module/podcast/services/category_operations.dart';

import 'models/category.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  Widget createCategory(Category category){
    return Container(
      color: Colors.blueGrey.shade400,
      child: Row(
        children: [
          Image.network(category.imageURL,),
          Text(category.name),
        ],
      ),
    );
  }

  createListOfCategories()
  {
    List<Category> categoryList=CategoryOperations.getCategories();
    List<Widget>categories=categoryList.map((Category category)=>createCategory(category)).toList();
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("app"),
      ),
      body: GridView.count(
        childAspectRatio: 5/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,

        crossAxisCount: 2,
      children: createListOfCategories(),


      ),

    );
  }
}
