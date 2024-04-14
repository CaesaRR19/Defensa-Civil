import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosContainer extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String details;
  final String youtubeUrl;
  
  const VideosContainer({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.details,
    required this.youtubeUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: const Color.fromARGB(255, 25, 1, 64),
          isScrollControlled: true,
          builder: (BuildContext context) {
            return ModalVideos(
              name: name,
              details: details,
              youtubeUrl: youtubeUrl,
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(imageUrl),
              height: 200,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'Impact',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModalVideos extends StatelessWidget {
  final String name;
  final String details;
  final String youtubeUrl;

  const ModalVideos({
    Key? key,
    required this.name,
    required this.details,
    required this.youtubeUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videoId = YoutubePlayer.convertUrlToId(youtubeUrl);

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 14, 7, 7),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            name,
            style: const TextStyle(
              fontFamily: 'Impact',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: videoId!,
              flags: const YoutubePlayerFlags(
                autoPlay: true,
              ),
            ),
            showVideoProgressIndicator: true,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              details,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: const Text(
              'Cerrar',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
