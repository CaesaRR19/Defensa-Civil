import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:defensa_civil/pages/videos/video_container.dart'; // Importa VideosContainer

class VideosBody extends StatefulWidget {
  @override
  _VideosBodyState createState() => _VideosBodyState();
}

class _VideosBodyState extends State<VideosBody> {
  List<dynamic> videos = [];

  @override
  void initState() {
    super.initState();
    _fetchVideos();
  }

  Future<void> _fetchVideos() async {
    try {
      final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/videos.php'));
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['exito']) {
        setState(() {
          videos = jsonResponse['datos'];
        });
      } else {
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      print('Error fetching videos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return _buildVideoItem(videos[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVideoItem(dynamic video) {
    String videoId = video['link'];
    String thumbnailUrl = 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';

    double fontSize = MediaQuery.of(context).size.width * 0.04;

    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Image.network(
              thumbnailUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            title: Text(
              video['titulo'],
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              video['descripcion'],
              style: TextStyle(
                fontSize: fontSize * 0.8,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
             showModalBottomSheet(
                context: context,
                backgroundColor: const Color.fromARGB(254, 25, 1, 64),
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Center(
                    child: ModalVideos(
                      name: video['titulo'], // Usa el título del video como nombre
                      details: video['descripcion'], // Usa la descripción del video como detalles
                      youtubeUrl: 'https://www.youtube.com/watch?v=$videoId', // Construye la URL de YouTube
                    ),
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(
              'Ver video',
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
