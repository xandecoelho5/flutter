import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  const AdaptativeDatePicker({required this.selectedDate, required this.onDateChanged, Key? key})
      : super(key: key);

  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform.name == 'iOS';
    return isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChanged,
            ),
          )
        : SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                    child: Text('Data Selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}')),
                TextButton(
                  onPressed: () => _showDatePicker(context),
                  style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.primary),
                  child:
                      const Text('Selecionar Data', style: TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
            ),
          );
  }
}
