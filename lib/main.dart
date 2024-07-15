import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import 'pages/tile/image_tile.dart';
import 'pages/music/music_play.dart';
import 'common/network/request_client.dart';
import 'pages/tile/image_tile_provider.dart';

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
  //播放器状态·
  bool isPlaying = false;
  //播放插件
  final player = AudioPlayer();
  //播放列表
  List<Map> playList = [];
  //当前播放歌曲索引
  int currentAudioIndex = -1;

  
  Future<void> _initImage() async {
    //网络请求获取图片列表
    RequestClient fRequestClient = RequestClient();
    final response = await fRequestClient.request("/music/pageList");
    if(response["code"] != 200){
        return;
    }else{
      Map data = response["data"];
      setState(() {
          for(int i = 0; i < data["records"].length; i++){
            playList.add(data["records"][i]);
          }
      });
    }
  }

   //播放指定声音
  Future<void> _handlePlayAudio(int index) async {
    // String url =  "https://sis-sample-audio.obs.cn-north-1.myhuaweicloud.com/16k16bit.mp3";
    String url = playList[index]["musicUrl"];
    await player.setUrl(url);
    player.play();
    setState(() {
      isPlaying = true;
      currentAudioIndex = index;
    });
  }

  //播放/暂停
  Future<void> togglePlayPause() async {
    if(currentAudioIndex == -1){
      return;
    }

    if (isPlaying) {
      await player.pause();
      setState(() {
        isPlaying = false;
      });
    }else{
      player.play();
    }
  }

  //下一首
  void playNext() {
    if(currentAudioIndex == -1 || (currentAudioIndex +  1) >= playList.length){
      return;
    }
    _handlePlayAudio(currentAudioIndex + 1);
  }

  //上一首
  void playPrevious() {
     if(currentAudioIndex == -1 || (currentAudioIndex - 1) <= 0){
      return;
    }
    _handlePlayAudio(currentAudioIndex - 1);
  }

  //初始化图片页面
  @override
  void initState()  {
    super.initState();
    _initImage();
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
              itemCount: playList.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider(
                  create: (context) => ImageTileProvider(
                    imageUrl: playList[index]["imageUrl"],
                  ),
                  child: ImageTile(
                    onTap: () async {
                      _handlePlayAudio(index);
                    }
                  ),
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
              songTitle: "龙卷风-dzq",
              songDuration: "5",
              currentProgress: "3",
              thumbnailUrl: "https://www.runoob.com/wp-content/themes/runoob/assets/images/qrcode.png",

            ),
          ),
        ],
      ),
    );
  }

}