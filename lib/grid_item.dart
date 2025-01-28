import 'package:flutter/material.dart';

Widget gridItem(context, String imgURL, String title) {
  return Container(
    padding: const EdgeInsets.all(8),
    height: 200,
    color: Colors.deepOrangeAccent,
    child: Card(
      child: Column(
        children: [
          Image.network(imgURL, height: 100, width: 100),
          Text(title),
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Item added to cart")));
              },
              icon: const Icon(Icons.shopping_cart)),
        ],
      ),
    ),
  );
}
