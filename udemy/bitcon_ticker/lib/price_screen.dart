import 'dart:io' show Platform;

import 'package:bitcon_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? _selectedCurrency = 'USD';
  Map<String, int?> coinValues = {};

  @override
  void initState() {
    super.initState();
    cryptoList.map((c) => coinValues[c] = null);
    _getData();
  }

  void _getData() async {
    final coinData = CoinData();

    for (String crypto in cryptoList) {
      coinValues[crypto] = await coinData.getCoinData(
        base: crypto,
        quote: _selectedCurrency!,
      );
    }
  }

  DropdownButton<String> androidDropdown() {
    final List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      dropdownItems.add(
        DropdownMenuItem(value: currency, child: Text(currency)),
      );
    }

    return DropdownButton<String>(
      value: _selectedCurrency,
      items: dropdownItems,
      onChanged: (value) => setState(() {
        _selectedCurrency = value;
        _getData();
      }),
    );
  }

  CupertinoPicker iOSPicker() {
    final List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        _selectedCurrency = currenciesList[selectedIndex];
        _getData();
      },
      children: pickerItems,
    );
  }

  List<Widget> _buildDisplays() {
    List<Widget> widgets = [];
    for (String crypto in cryptoList) {
      widgets.add(Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 $crypto = ${coinValues[crypto] ?? '?'} $_selectedCurrency',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ),
        ),
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🤑 Coin Ticker')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(children: _buildDisplays()),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
