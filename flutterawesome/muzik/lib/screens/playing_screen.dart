import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muzik/utils/assets.dart';
import 'package:muzik/widgets/custom_app_bar.dart';

class PlayingScreen extends StatelessWidget {
  const PlayingScreen({Key? key}) : super(key: key);

  _image(double height) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.ministerGuc),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  _song() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(Assets.heartOutlined),
          Column(
            children: const [
              Text(
                'Mercy Chinwo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              SizedBox(height: 4),
              Text('Minister GUC'),
            ],
          ),
          SvgPicture.asset(Assets.downloadOutlined),
        ],
      ),
    );
  }

  _slider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Slider(
            value: 0.2,
            onChanged: (value) {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('01:35', style: TextStyle(fontSize: 18)),
                Text('03:38', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _controls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(Assets.shuffle),
          SvgPicture.asset(Assets.skipBackward),
          Image.asset(
            Assets.pause,
            height: 80,
            width: 80,
          ),
          SvgPicture.asset(Assets.skipForward),
          SvgPicture.asset(Assets.repeat),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar.build(context),
      body: Column(
        children: [
          _image(deviceHeight * 0.485),
          SizedBox(height: deviceHeight * 0.035),
          _song(),
          SizedBox(height: deviceHeight * 0.065),
          _slider(),
          SizedBox(height: deviceHeight * 0.03),
          _controls(),
        ],
      ),
    );
  }
}
