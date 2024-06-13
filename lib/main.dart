import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter_application_1/UI/image_tile.dart';
import 'package:flutter_application_1/music/music_play.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _handleImageTap() {
    print('Image tapped!');
  }

  bool isPlaying = false;

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void playNext() {
    // Implement play next functionality
  }

  void playPrevious() {
    // Implement play previous functionality
  }


  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
      ),
      body: Stack(
        children: [
          // Your main content here
           MasonryGridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemBuilder: (context, index) {
                return ImageTile(
                  imageUrl: 'https://www.runoob.com/wp-content/themes/runoob/assets/images/qrcode.png', 
                  onTap: _handleImageTap
                  );
              },
            ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: MusicPlay(
              isPlaying: isPlaying,
              onPlayPause: togglePlayPause,
              onNext: playNext,
              onPrevious: playPrevious,
            ),
          ),
        ],
      ),
    );
  }

}