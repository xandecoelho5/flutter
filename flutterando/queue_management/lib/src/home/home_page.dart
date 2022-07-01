import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          ElevatedButton(onPressed: () {}, child: Text('Entrada')),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: () {}, child: Text('Salão')),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: () {}, child: Text('Guichê')),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/config');
              },
              child: Text('Configurações')),
        ],
      ),
    );
  }
}
