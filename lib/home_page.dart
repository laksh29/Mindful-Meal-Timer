import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'buttons_widget.dart';
import 'clock_widget.dart';
import 'constants.dart';
import 'indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  static const int timeLimit = 30;
  late AnimationController controller;
  late Animation animation;
  bool isplaying = false;
  bool isMusicOn = true;
  bool counterStarted = false;
  int index = 0;
  double progressValue = 1.0;

  final audioPath = "countdown_tick.mp3";

  final AudioPlayer player = AudioPlayer();

  String get counterText {
    Duration count =
        controller.duration! * controller.value == const Duration(seconds: 0)
            ? controller.duration!
            : controller.duration! * controller.value;
    return "${(count.inMinutes % 60).toString().padLeft(2, '0')} : ${(count.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: timeLimit,
      ),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.addListener(() {
      if (controller.isAnimating) {
        setState(() {
          progressValue = controller.value;
        });
      } else {
        setState(() {
          progressValue = 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // play audio
    if (controller.value < 0.18 && controller.value > 0.00) {
      player.play(AssetSource(audioPath), volume: isMusicOn ? 1.0 : 0);
      setState(() {
        counterStarted = true;
      });
    }

    // reset controller
    if (counterStarted && controller.value == 0.0) {
      controller.reset();

      setState(() {
        if (index == 2) {
          index = 0;
        } else {
          index++;
        }
        isplaying = false;
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xff191725),
      appBar: AppBar(
        backgroundColor: const Color(0xff191725),
        title: const Text("Mindful Meal Timer"),
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        shadowColor: Colors.white10,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // index markings
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Indicator(
                  index: index,
                  activeIndex: 0,
                ),
                buildWidth(5.0),
                Indicator(
                  index: index,
                  activeIndex: 1,
                ),
                buildWidth(5.0),
                Indicator(
                  index: index,
                  activeIndex: 2,
                ),
              ],
            ),
            // title
            Text(
              title[index],
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            // sub-title
            Text(
              subTitle[index],
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white54,
              ),
              textAlign: TextAlign.center,
            ),
            // counter clock
            CounterClock(
                controller: controller,
                counterText: counterText,
                animation: animation),
            // cupertino toggle
            Wrap(
              direction: Axis.vertical,
              spacing: 5.0,
              children: [
                CupertinoSwitch(
                    value: isMusicOn,
                    onChanged: (t) => setState(() {
                          isMusicOn = t;
                        })),
                Text(isMusicOn ? "Sound On" : "Sound Off"),
              ],
            ),
            // buttons
            Wrap(
              spacing: 10.0,
              direction: Axis.vertical,
              children: [
                ButtonWidget(
                  text: isplaying ? "PAUSE" : "PLAY",
                  onClicked: () {
                    if (controller.isAnimating) {
                      controller.stop();
                      setState(() {
                        isplaying = false;
                      });
                    } else {
                      controller.reverse(
                        from: controller.value == 0 ? 1.0 : controller.value,
                      );
                      setState(() {
                        isplaying = true;
                      });
                    }
                  },
                ),
                buildHeight(5.0),
                ButtonWidget(
                  text: "LET'S STOP I'M FULL NOW",
                  secondary: true,
                  onClicked: () {},
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
