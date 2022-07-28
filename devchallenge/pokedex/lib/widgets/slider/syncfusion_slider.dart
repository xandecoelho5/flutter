import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../utils/constants.dart';

class SyncfusionSlider extends StatefulWidget {
  const SyncfusionSlider({
    Key? key,
    required this.rangeValues,
    required this.onChangeEnd,
  }) : super(key: key);

  final RangeValues rangeValues;
  final Function(SfRangeValues) onChangeEnd;

  @override
  State<SyncfusionSlider> createState() => _SyncfusionSliderState();
}

const min = 1;
const max = 898;

class _SyncfusionSliderState extends State<SyncfusionSlider> {
  late SfRangeValues _values = SfRangeValues(
    widget.rangeValues.start,
    widget.rangeValues.end,
  );

  _calculateWidth(values, width) {
    final div = values / max;
    return div * width - _getExtraPadding(div);
  }

  _getExtraPadding(div) {
    if (div > 0.95) return 24;
    if (div > 0.6) return 15;
    if (div > 0.3) return 10;
    if (div > 0.1) return 5;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 72;

    return SfRangeSliderTheme(
      data: SfRangeSliderThemeData(
        inactiveTrackColor: kBackgroundDefaultInput,
        thumbColor: Colors.white,
        thumbStrokeColor: kTypePsychic,
        thumbStrokeWidth: 5,
        thumbRadius: 12,
        overlayRadius: 10,
        overlappingThumbStrokeColor: kTypePsychic,
        overlappingTooltipStrokeColor: kTypePsychic,
      ),
      child: Column(
        children: [
          SfRangeSlider(
            min: min,
            max: max,
            values: _values,
            enableTooltip: true,
            numberFormat: NumberFormat('00'),
            onChanged: (SfRangeValues values) {
              setState(() {
                _values = values;
              });
            },
            onChangeEnd: widget.onChangeEnd,
          ),
          Stack(
            children: [
              SizedBox(
                height: 15,
                width: width,
              ),
              Positioned(
                left: _calculateWidth(_values.start, width),
                child: Text(
                  _values.start.round().toString().padLeft(2, '0'),
                  style: const TextStyle(color: kTextGrey, fontSize: 14),
                ),
              ),
              Positioned(
                left: _calculateWidth(_values.end, width),
                child: Text(
                  _values.end.round().toString(),
                  style: const TextStyle(color: kTextGrey, fontSize: 14),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
