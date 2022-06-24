import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi/utils/calculator.dart';
import 'package:ibmi/widgets/info_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BMIPage extends StatefulWidget {
  const BMIPage({Key? key}) : super(key: key);

  @override
  State<BMIPage> createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  double? _deviceHeight, _deviceWidth;

  int _age = 25, _weight = 160, _height = 70, _gender = 0;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      child: Center(
        child: SizedBox(
          height: _deviceHeight! * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ageSelectedContainer(),
                  _weightSelectedContainer(),
                ],
              ),
              _heightSelectContainer(),
              _genderSelectContainer(),
              _calculateBMIButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ageSelectedContainer() {
    return InfoCard(
      height: _deviceHeight! * 0.2,
      width: _deviceWidth! * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Age yr',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          Text(
            '$_age',
            style: const TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  key: const Key('age_minus'),
                  textStyle: const TextStyle(fontSize: 25, color: Colors.red),
                  onPressed: () => setState(() => _age--),
                  child: const Text('-'),
                ),
              ),
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  key: const Key('age_plus'),
                  textStyle: const TextStyle(fontSize: 25, color: Colors.blue),
                  onPressed: () => setState(() => _age++),
                  child: const Text('+'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _weightSelectedContainer() {
    return InfoCard(
      height: _deviceHeight! * 0.2,
      width: _deviceWidth! * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Weight lbs',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          Text(
            '$_weight',
            style: const TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  key: const Key('weight_minus'),
                  textStyle: const TextStyle(fontSize: 25, color: Colors.red),
                  onPressed: () => setState(() => _weight--),
                  child: const Text('-'),
                ),
              ),
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  key: const Key('weight_plus'),
                  textStyle: const TextStyle(fontSize: 25, color: Colors.blue),
                  onPressed: () => setState(() => _weight++),
                  child: const Text('+'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _heightSelectContainer() {
    return InfoCard(
      width: _deviceWidth! * 0.9,
      height: _deviceHeight! * 0.2,
      child: Column(
        children: [
          const Text(
            'Height in',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          Text(
            '$_height',
            style: const TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: _deviceWidth! * 0.8,
            child: CupertinoSlider(
              value: _height.toDouble(),
              min: 0,
              max: 96,
              divisions: 96,
              onChanged: (value) => setState(() => _height = value.toInt()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _genderSelectContainer() {
    return InfoCard(
      width: _deviceWidth! * 0.9,
      height: _deviceHeight! * 0.11,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Gender',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          CupertinoSlidingSegmentedControl(
            groupValue: _gender,
            children: const {
              0: Text('Male'),
              1: Text('Female'),
            },
            onValueChanged: (value) => setState(() => _gender = value as int),
          ),
        ],
      ),
    );
  }

  Widget _calculateBMIButton() {
    return SizedBox(
      height: _deviceHeight! * 0.07,
      child: CupertinoButton.filled(
        child: const Text('Calculate BMI'),
        onPressed: () {
          if (_height > 0 && _weight > 0 && _age > 0) {
            double bmi = calculateBMI(_height, _weight);
            _showResultDialog(bmi);
          }
        },
      ),
    );
  }

  void _showResultDialog(double bmi) {
    String status = 'Obese';
    if (bmi < 18.5) {
      status = 'Underweight';
    } else if (bmi < 25) {
      status = 'Normal';
    } else if (bmi < 30) {
      status = 'Overweight';
    }
    showCupertinoDialog(
      context: context,
      builder: (ctx) {
        return CupertinoAlertDialog(
          title: Text(status),
          content: Text(bmi.toStringAsFixed(2)),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                _saveResult(bmi.toString(), status);
                Navigator.pop(ctx);
              },
            ),
          ],
        );
      },
    );
  }

  void _saveResult(String bmi, String status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('bmi_date', DateTime.now().toString());
    await prefs.setStringList('bmi_data', [bmi, status]);
  }
}
