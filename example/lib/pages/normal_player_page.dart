import 'package:better_player/better_player.dart';
import 'package:better_player_example/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NormalPlayerPage extends StatefulWidget {
  @override
  _NormalPlayerPageState createState() => _NormalPlayerPageState();
}

class _NormalPlayerPageState extends State<NormalPlayerPage> {
  late BetterPlayerController betterPlayerController;
  late BetterPlayerDataSource betterPlayerDataSource;
  final BetterPlayerConfiguration betterPlayerConfiguration =
      BetterPlayerConfiguration();
  late BetterPlayerBufferingConfiguration bufferingConfiguration;
  late BetterPlayerEvent betterPlayerEvent;
  late BetterPlayerDrmConfiguration betterPlayerDrmConfiguration;
  late BetterPlayerControlsConfiguration betterPlayerControlsConfiguration;

  var startTIme = "0:02:50.208000";
  Duration prog = Duration();

  late Duration dur = Duration(
    hours: 0,
    minutes: 0,
    seconds: 0,
    milliseconds: 0,
    microseconds: 0,
  );
  Map<dynamic, dynamic>? progress = null;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
      // startAt: strToDuration(startTIme),
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoPlay: true,
      looping: true,
    );

    betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      Constants.elephantDreamStreamUrl,
    );

    betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    betterPlayerController.setupDataSource(betterPlayerDataSource);
    print("Init");
    betterPlayerController.addEventsListener((BetterPlayerEvent event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.pause) {
        print(progress!['progress']);
        setState(() {
          prog = progress!['progress'];
        });
      } else if (event.betterPlayerEventType ==
          BetterPlayerEventType.progress) {
        progress = event.parameters;
      }
    });
    betterPlayerControlsConfiguration = BetterPlayerControlsConfiguration(
      showControls: true,
    );

    super.initState();
  }

  Duration strToDuration(String du) {
    var dut = du.split(':');

    return Duration(
      hours: int.parse(dut[0]),
      minutes: int.parse(dut[1]),
      seconds: int.parse(dut[2].split('.')[0]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.8),
      appBar: AppBar(
        title: Text("Normal player page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: BetterPlayer(controller: betterPlayerController),
            ),
            const SizedBox(height: 8),
            Text(betterPlayerConfiguration.startAt.toString()),
            InkWell(
              onDoubleTap: () {
                print("object");
              },
              splashColor: Colors.black,
              child: Container(
                height: 100,
                width: 100,
              ),
            ),
            // Text(
            // BetterPlayerUtils.formatDuration(duration),
            // ),
            InkWell(
              splashColor: Colors.white,
              onTap: () {},
              child: Text("Click"),
            ),
            SizedBox(height: 10),
            Tooltip(
              child: Text("SHow"),
              showDuration: Duration(seconds: 2),
              waitDuration: Duration(seconds: 2),
              message: "message",
              textStyle: TextStyle(color: Colors.black),
            ),

            SizedBox(height: 10),
            Text(dur.toString()),
            // Text( .toString()),

            Text(prog.toString()),
          ],
        ),
      ),
    );
  }
}
