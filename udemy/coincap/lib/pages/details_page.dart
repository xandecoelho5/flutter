import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.prices}) : super(key: key);

  final Map<String, dynamic> prices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor: const Color.fromRGBO(88, 60, 197, 1.0),
      ),
      body: ListView(
        children: prices.entries.map((entry) {
          return ListTile(
            title: Text(
              '${entry.key.toUpperCase()}: ${entry.value}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
