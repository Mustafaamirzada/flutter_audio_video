import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class Landscape extends StatefulWidget {
  const Landscape({super.key, required this.controller});
  final VideoPlayerController controller;

  @override
  State<Landscape> createState() => _LandscapeState();
}

class _LandscapeState extends State<Landscape> {
  Future _landscapeMode() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future _setAllOrientation() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void initState() {
    super.initState();
    _landscapeMode();
  }

  @override
  void dispose() {
    super.dispose();
    _setAllOrientation();
  }

  @override
  Widget build(BuildContext context) => VideoPlayer(widget.controller);
}
