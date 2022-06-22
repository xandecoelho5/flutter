import 'package:coincap/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'details_page.dart';

const coins = ['bitcoin', 'ethereum', 'tether', 'cardano', 'ripple'];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final coins = ['bitcoin', 'ethereum', 'tether', 'cardano', 'ripple'];
  HttpService? _http;
  double? _deviceHeight, _deviceWidth;
  String? _selectedCoin = coins.first;

  @override
  void initState() {
    super.initState();
    _http = GetIt.instance.get<HttpService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _selectedCoinDropdown(),
              _dataWidgets(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectedCoinDropdown() {
    final dropdownItems = coins
        .map((coin) => DropdownMenuItem(
              value: coin,
              child: Text(
                coin,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ))
        .toList();

    return DropdownButton<String>(
      value: _selectedCoin,
      items: dropdownItems,
      onChanged: (value) {
        setState(() => _selectedCoin = value);
      },
      dropdownColor: const Color.fromRGBO(83, 88, 206, 1.0),
      iconSize: 30,
      icon: const Icon(Icons.arrow_drop_down_sharp, color: Colors.white),
      underline: Container(),
    );
  }

  Widget _dataWidgets() {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _http!.get('/coins/$_selectedCoin'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          num usdPrice = data!['market_data']['current_price']['usd'];
          num changed24h = data['market_data']['price_change_percentage_24h'];

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onDoubleTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(
                          prices: data['market_data']['current_price']),
                    ),
                  );
                },
                child: _coinImageWidget(data['image']['large']),
              ),
              _currentPriceWidget(usdPrice),
              _percentageChangeWidget(changed24h),
              _descriptionCardWidget(data['description']['en']),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
      },
    );
  }

  Widget _currentPriceWidget(num rate) {
    return Text(
      '${rate.toStringAsFixed(2)} USD',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _percentageChangeWidget(num change) {
    return Text(
      '$change %',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _coinImageWidget(String imgUrl) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.02),
      height: _deviceHeight! * 0.15,
      width: _deviceWidth! * 0.15,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(imgUrl)),
      ),
    );
  }

  Widget _descriptionCardWidget(String description) {
    return Container(
      height: _deviceHeight! * 0.45,
      width: _deviceWidth! * 0.9,
      margin: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.05),
      padding: EdgeInsets.symmetric(
        vertical: _deviceHeight! * 0.01,
        horizontal: _deviceWidth! * 0.01,
      ),
      color: const Color.fromRGBO(83, 88, 206, 0.5),
      child: Text(
        description,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
