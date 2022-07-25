import 'package:flutter/material.dart';
import 'package:pokedex/utils/constants.dart';

import 'circle_thumb_shape.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  @override
  Widget build(BuildContext context) {
    // TODO verificar porque essa porra não funciona com o RangeSlider, mas funciona com o Slider...
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: kTypePsychic,
        inactiveTrackColor: kBackgroundDefaultInput,
        trackHeight: 4,
        rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
        trackShape: const RoundedRectSliderTrackShape(),
        thumbColor: kTypePsychic,
        thumbShape: const CircleThumbShape(thumbRadius: 20),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 1),
      ),
      child: Column(
        children: [
          RangeSlider(
            min: 1,
            max: 898,
            values: _currentRangeValues,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            onChanged: (values) => setState(() => _currentRangeValues = values),
          ),
          Row(
            children: [
              Text(
                _currentRangeValues.start.round().toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                _currentRangeValues.end.round().toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
