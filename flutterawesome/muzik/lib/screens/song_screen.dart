import 'package:flutter/material.dart';
import 'package:muzik/utils/assets.dart';
import 'package:muzik/widgets/buttons_row.dart';
import 'package:muzik/widgets/custom_app_bar.dart';
import 'package:muzik/widgets/custom_card.dart';

class SongScreen extends StatelessWidget {
  const SongScreen({Key? key}) : super(key: key);

  List<Widget> _infoColumn(String label, String value) {
    return [
      Text(
        label,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        value,
        style: const TextStyle(fontSize: 24),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 258,
                    child: CustomCard(imageUrl: Assets.chinweOwo, width: 258),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Mercy Chinwo',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'THE CROSS: MY GAZE'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const ButtonsRow(
                    plays: 20,
                    downloads: 244,
                    likes: 50,
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
              const Divider(
                color: Colors.white,
                thickness: 0.4,
              ),
              const SizedBox(height: 16),
              ..._infoColumn('Album:', 'The Cross: My Gaze'.toUpperCase()),
              const SizedBox(height: 24),
              ..._infoColumn('Release Date:', 'April 12, 2019'),
              const SizedBox(height: 24),
              ..._infoColumn('Genre:', 'Gospel'),
            ],
          ),
        ),
      ),
    );
  }
}
