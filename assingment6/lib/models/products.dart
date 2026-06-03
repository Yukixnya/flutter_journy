import 'package:flutter/material.dart';

class Products {
  final String name;
  final String description;
  double price;

  Products({
    required this.name,
    required this.description,
    required this.price,
  });
}

class ProductList {
  List<Products> getProducts() {
      return [
        Products(
          name: 'Product 1',
          description: 'Description for Product 1',
          price: 10.0,
        ),
      Products(
        name: 'Product 2',
        description: 'Description for Product 2',
        price: 20.0,
      ),
      Products(
        name: 'Product 3',
        description: 'Description for Product 3',
        price: 30.0,
      ),
      Products(
        name: 'Product 4',
        description: 'Description for Product 4',
        price: 40.0,
      ),
      Products(
        name: 'Product 5',
        description: 'Description for Product 5',
        price: 50.0,
      ),
      Products(
        name: 'Product 6',
        description: 'Description for Product 6',
        price: 60.0,
      ),
      Products(
        name: 'Product 7',
        description: 'Description for Product 7',
        price: 70.0,
      ),
      Products(
        name: 'Product 8',
        description: 'Description for Product 8',
        price: 80.0,
      ),
      Products(
        name: 'Product 9',
        description: 'Description for Product 9',
        price: 90.0,
      ),
      Products(
        name: 'Product 10',
        description: 'Description for Product 10',
        price: 100.0,
      ),
      Products(
        name: 'Product 11',
        description: 'Description for Product 11',
        price: 110.0,
      ),
      Products(
        name: 'Product 12',
        description: 'Description for Product 12',
        price: 120.0,
      ),
      Products(
        name: 'Product 13',
        description: 'Description for Product 13',
        price: 130.0,
      ),
      Products(
        name: 'Product 14',
        description: 'Description for Product 14',
        price: 140.0,
      ),
      Products(
        name: 'Product 15',
        description: 'Description for Product 15',
        price: 150.0,
      ),
      Products(
        name: 'Product 16',
        description: 'Description for Product 16',
        price: 160.0,
      ),
      Products(
          name: 'Product 17',
          description: 'Description for Product 17',
          price: 170.0,
        ),
      Products(
          name: 'Product 18',
          description: 'Description for Product 18',
          price: 180.0,
        ),
        Products(
            name: 'Product 19',
            description: 'Description for Product 19',
            price: 190.0,
          ),
        Products(
            name: 'Product 20',
            description: 'Description for Product 20',
            price: 200.0,
          )
    ];  
  }
}