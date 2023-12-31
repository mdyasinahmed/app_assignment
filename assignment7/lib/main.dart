import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: 'Product 1', price: 10),
    Product(name: 'Product 2', price: 20),
    Product(name: 'Product 3', price: 30),
    Product(name: 'Product 4', price: 40),
    Product(name: 'Product 5', price: 50),
    Product(name: 'Product 6', price: 60),
    Product(name: 'Product 7', price: 70),
    Product(name: 'Product 8', price: 80),
    Product(name: 'Product 9', price: 90),
    Product(name: 'Product 10', price: 100),
    Product(name: 'Product 11', price: 110),
    Product(name: 'Product 12', price: 120),
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(products: products),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price.toStringAsFixed(2)}'),
            trailing: BuyButton(
              product: products[index],
              onBuy: () {
                setState(() {
                  products[index].incrementCount();
                  if (products[index].count == 5) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Congratulations!'),
                          content: Text('You\'ve bought 5 ${products[index].name}!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(products: products),
            ),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  int count = 0;

  Product({required this.name, required this.price});

  void incrementCount() {
    count++;
  }
}

class BuyButton extends StatelessWidget {
  final Product product;
  final VoidCallback onBuy;

  BuyButton({required this.product, required this.onBuy});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onBuy,
      child: Text('Buy Now (${product.count})'),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage({required this.products});

  @override
  Widget build(BuildContext context) {
    int totalProductsBought = products.fold(0, (sum, product) => sum + product.count);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Total Products Bought: $totalProductsBought'),
          SizedBox(height: 20),
          Text('Products in Cart:'),
          for (var product in products)
            if (product.count > 0)
              ListTile(
                title: Text('${product.name} (${product.count})'),
                subtitle: Text('\$${(product.price * product.count).toStringAsFixed(2)}'),
              ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductList(),
    );
  }
}
