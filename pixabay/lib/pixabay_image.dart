class PixabayImage {
  final String webformatURL;
  final String previewURL;
  final int likes;

  PixabayImage({
    required this.webformatURL,
    required this.previewURL,
    required this.likes,
  });

  factory PixabayImage.fromMap(Map<String, dynamic> map) {
    return PixabayImage(
      webformatURL: map['webformatURL'],
      previewURL: map['previewURL'],
      likes: map['likes'],
    );
  }

  static List<PixabayImage> fromJson(List jsonList) {
    return jsonList.map((json) => PixabayImage.fromMap(json)).toList();
  }
}
