import 'dart:io';
import 'package:better_player_example/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'normal_player_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    _saveAssetSubtitleToFile();
    _saveAssetVideoToFile();
    _saveAssetEncryptVideoToFile();
    _saveLogoToFile();
    super.initState();
  }

  var _toolTipKey = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Better Player Example"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            Tooltip(
              message: 'My Account',
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {},
                child: Icon(
                  Icons.account_box,
                  size: 50,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print("object");
              },
              child: Tooltip(
                triggerMode: TooltipTriggerMode.tap,
                message: "Your message",
                child: Icon(
                  Icons.info,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  splashColor: Colors.black,
                  child: Container(
                    height: 100,
                    width: 100,
                  ),
                ),
                InkWell(
                  onTap: () {
                    print("object");
                  },
                  splashColor: Colors.red,
                  child: Container(
                    height: 100,
                    width: 100,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...buildExampleElementWidgets()
          ],
        ),
      ),
    );
  }

  List<Widget> buildExampleElementWidgets() {
    return [
      _buildExampleElementWidget("Normal player", () {
        _navigateToPage(NormalPlayerPage());
      }),
    ];
  }

  Widget _buildExampleElementWidget(String name, Function onClicked) {
    return Material(
      child: InkWell(
        onTap: onClicked as void Function()?,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                name,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Future _navigateToPage(Widget routeWidget) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => routeWidget),
    );
  }

  ///Save subtitles to file, so we can use it later
  Future _saveAssetSubtitleToFile() async {
    String content =
        await rootBundle.loadString("assets/example_subtitles.srt");
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/example_subtitles.srt");
    file.writeAsString(content);
  }

  ///Save video to file, so we can use it later
  Future _saveAssetVideoToFile() async {
    var content = await rootBundle.load("assets/testvideo.mp4");
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/testvideo.mp4");
    file.writeAsBytesSync(content.buffer.asUint8List());
  }

  Future _saveAssetEncryptVideoToFile() async {
    var content =
        await rootBundle.load("assets/${Constants.fileTestVideoEncryptUrl}");
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/${Constants.fileTestVideoEncryptUrl}");
    file.writeAsBytesSync(content.buffer.asUint8List());
  }

  ///Save logo to file, so we can use it later
  Future _saveLogoToFile() async {
    var content = await rootBundle.load("assets/${Constants.logo}");
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/${Constants.logo}");
    file.writeAsBytesSync(content.buffer.asUint8List());
  }
}
