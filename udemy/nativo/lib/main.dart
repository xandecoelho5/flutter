import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _a = 0;
  int _b = 0;
  int _sum = 0;

  Future<void> _calcSum() async {
    const channel = MethodChannel('cod3r.com.br/nativo');

    try {
      final sum = await channel.invokeMethod('calcSum', {'a': _a, 'b': _b});
      setState(() => _sum = sum);
    } on PlatformException {
      setState(() => _sum = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nativo')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Soma... $_sum',
                style: const TextStyle(fontSize: 30),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    setState(() => _a = int.tryParse(value) ?? 0),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    setState(() => _b = int.tryParse(value) ?? 0),
              ),
              ElevatedButton(
                onPressed: _calcSum,
                child: const Text('Somar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
