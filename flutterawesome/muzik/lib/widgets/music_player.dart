import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muzik/utils/assets.dart';
import 'package:muzik/widgets/custom_card.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  _container() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.only(left: 16, right: 8),
      decoration: const BoxDecoration(
        color: Color(0xff1B1919),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 3),
                child: Row(
                  children: [
                    const CustomCard(
                      imageUrl: Assets.splash,
                      width: 55,
                      radius: 20,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Oh Jesus',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Oh Jesus',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    IconButton(
                      splashRadius: 20,
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
                      icon: SvgPicture.asset(Assets.skipBackward),
                    ),
                    IconButton(
                      splashRadius: 30,
                      splashColor: const Color(0xFFB87629).withOpacity(0.5),
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
                      icon: Image.asset(Assets.pause),
                      iconSize: 60,
                    ),
                    IconButton(
                      splashRadius: 20,
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
                      icon: SvgPicture.asset(Assets.skipForward),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _progressIndicator() {
    return const LinearProgressIndicator(
      value: 0.32,
      minHeight: 2,
      backgroundColor: Colors.white,
      color: Color(0xFFB87629),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _container(),
        _progressIndicator(),
      ],
    );
  }
}
