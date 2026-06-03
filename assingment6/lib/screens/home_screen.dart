import 'package:flutter/material.dart';
import '../models/products.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int likecnt = 0;
  @override
  Widget build(BuildContext context) {
    final productList = ProductList().getProducts();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Buy Sell App', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Text('App Liked By: $likecnt',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),  
          ],
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: GridView.builder(
        itemCount: productList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final product = productList[index];
          return Card(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(product.name),
                  Text(product.description),
                  Text('\$${product.price}'),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 50),
        child: SizedBox(
          height: 80,
          width: 80,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                likecnt++;
              });
            },
            child: Icon(Icons.thumb_up, size: 40,),
          ),
        ),
      ),
    );
  }
}
