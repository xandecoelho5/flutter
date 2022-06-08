import 'package:destini/story_brain.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Destini());

class Destini extends StatelessWidget {
  const Destini({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const StoryPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

StoryBrain storyBrain = StoryBrain();

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 12,
                child: Center(
                  child: Text(
                    storyBrain.getStory(),
                    style: const TextStyle(fontSize: 25.0),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () => setState(() => storyBrain.nextStory(1)),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Text(
                    storyBrain.getChoice1(),
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: storyBrain.buttonShouldBeVisible(),
                  child: ElevatedButton(
                    onPressed: () => setState(() => storyBrain.nextStory(2)),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    child: Text(
                      storyBrain.getChoice2(),
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
