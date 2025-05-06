import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Audio extends StatefulWidget {
  const Audio({super.key});

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  final audioplayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    setAudio();

    // ########### listen for playing change
    audioplayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    // listen for duration change
    audioplayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    // listen for position change
    audioplayer.onPositionChanged.listen((newposition) {
      setState(() {
        position = newposition;
      });
    });
  }

  Future setAudio() async {
    audioplayer.setReleaseMode(ReleaseMode.loop);

    await audioplayer.setSource(AssetSource('2024-07.mp3'));
    await audioplayer.resume();
  }

  @override
  void dispose() {
    audioplayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/musical.png',
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 32),
            Text(
              '🎼 Flutter Songs',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Music Name',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioplayer.seek(position);

                // play audio if it was paused
                await audioplayer.resume();
              },
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(formatTime(position)),
            //       Text(formatTime(duration - position)),
            //     ],
            //   ),
            // ),
            CircleAvatar(
              radius: 35,
              child: IconButton(
                onPressed: () async {
                  if (isPlaying) {
                    await audioplayer.pause();
                  } else {
                    await audioplayer.resume();
                  }
                },
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                iconSize: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}
