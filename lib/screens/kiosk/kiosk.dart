import 'package:flutter/material.dart';

class KioskScreen extends StatelessWidget {
  const KioskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const KioskHomePage();
  }
}

class KioskHomePage extends StatefulWidget {
  const KioskHomePage({super.key});

  @override
  _KioskHomePageState createState() => _KioskHomePageState();
}

class _KioskHomePageState extends State<KioskHomePage> {
  final List<String> categories = ['Electronics', 'Clothing', 'Books', 'Food'];
  final Map<String, List<String>> products = {
    'Electronics': ['Smartphone', 'Laptop', 'Tablet'],
    'Clothing': ['T-shirt', 'Jeans', 'Dress'],
    'Books': ['Novel', 'Textbook', 'Magazine'],
    'Food': ['Pizza', 'Burger', 'Salad'],
  };
  String selectedCategory = 'Electronics';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kiosk Interface'),
      ),
      body: Row(
        children: [
          // Category list
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categories[index]),
                  onTap: () {
                    setState(() {
                      selectedCategory = categories[index];
                    });
                  },
                  selected: selectedCategory == categories[index],
                );
              },
            ),
          ),
          // Product list
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: products[selectedCategory]?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products[selectedCategory]![index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
