import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../constant/string_constant.dart';

class VideoPlayerScreen extends StatelessWidget {
  final List<String> videoUrls;

  const VideoPlayerScreen({super.key, required this.videoUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Lectures'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          final String videoUrl = "${MyText.basicUrlApi}/${videoUrls[index]}";
        

          return VideoCard(videoUrl: videoUrl);
        },
      ),
    );
  }
}

class VideoCard extends StatefulWidget {
  final String videoUrl;

  const VideoCard({super.key, required this.videoUrl});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {}); // Refresh the UI once the video is initialized.
      }).catchError((e) {
        setState(() {
          // Set an error state or show an error message to the user.
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _controller.value.isInitialized
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenVideoPlayer(
                          controller: _controller,
                        ),
                      ),
                    );
                  },
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                )
              : const Center(
                  heightFactor: 3,
                  child: CircularProgressIndicator(),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
                setState(() {}); // Refresh to show the updated state.
              },
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
              label: Text(
                _controller.value.isPlaying ? 'Pause' : 'Play',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FullScreenVideoPlayer extends StatelessWidget {
  final VideoPlayerController controller;

  const FullScreenVideoPlayer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          ),
        ),
      ),
    );
  }
}
