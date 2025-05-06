// ignore_for_file: unused_field

import 'dart:io';

import 'package:audio_image/landscape.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _controller;
  final File newFile = File('');

  void _playVideo(File file) {
    _controller = VideoPlayerController.file(file)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => _controller.play());
  }

  Future<File?> pickVideoFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result == null) return null;

    return File(result.files.single.path ?? '');
  }

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  void initState() {
    _playVideo(newFile);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Video Page'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60),
              Stack(
                children: [
                  SizedBox(
                    height: 250,
                    child: VideoPlayer(_controller),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                Landscape(controller: _controller),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.fullscreen,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(right: 5, left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _controller,
                      builder: (context, VideoPlayerValue value, child) {
                        return Text(
                          _videoDuration(value.position),
                          style: TextStyle(
                            color: Colors.blueAccent.shade700,
                            fontSize: 20,
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 4,
                        child: VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          colors: VideoProgressColors(
                            playedColor: Colors.blueAccent.shade400,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 15,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      _videoDuration(_controller.value.duration),
                      style: TextStyle(
                        color: Colors.blueAccent.shade700,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play(),
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.blueAccent.shade400,
                  size: 40,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final pickFile = await pickVideoFile();
                  if (pickFile == null) return;
                  _playVideo(pickFile);
                },
                child: Text('Pick a Video'),
              ),
            ],
          ),
        ));
  }
}
