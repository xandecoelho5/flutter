import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi/widgets/info_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);

  double? _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      child: _dataCard(),
    );
  }

  Widget _dataCard() {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          final prefs = snapshot.data!;
          final date = prefs.getString('bmi_date');
          final data = prefs.getStringList('bmi_data');
          return Center(
            child: InfoCard(
              width: _deviceWidth! * 0.75,
              height: _deviceHeight! * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _statusText(data![1]),
                  _dateText(date!),
                  _bmiText(data[0]),
                ],
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _statusText(String status) {
    return Text(
      status,
      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
    );
  }

  Widget _dateText(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return Text(
      '${parsedDate.day} / ${parsedDate.month} / ${parsedDate.year}',
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
    );
  }

  Widget _bmiText(String bmi) {
    return Text(
      double.parse(bmi).toStringAsFixed(2),
      style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w600),
    );
  }
}
