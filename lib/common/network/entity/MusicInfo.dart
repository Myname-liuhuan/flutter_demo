class MusicInfo {
  String audioUrl;
  String miniImageurl;
  String audioName;
  int audioTimeLen;

  MusicInfo({
    required this.audioUrl,
    required this.miniImageurl,
    required this.audioName,
    required this.audioTimeLen,
  });

  // 从JSON解析到对象
  factory MusicInfo.fromJson(Map<String, dynamic> json) {
    return MusicInfo(
      audioUrl: json['audioUrl'],
      miniImageurl: json['miniImageurl'],
      audioName: json['audioName'],
      audioTimeLen: json['audioTimeLen'],
    );
  }

  // 将对象转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'audioUrl': audioUrl,
      'miniImageurl': miniImageurl,
      'audioName': audioName,
      'audioTimeLen': audioTimeLen,
    };
  }
}
