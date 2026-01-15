import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pixabay/pixabay_image.dart';
import 'package:share_plus/share_plus.dart';

class PixabayPage extends StatefulWidget {
  const PixabayPage({super.key});

  @override
  State<PixabayPage> createState() => _PixabayPageState();
}

class _PixabayPageState extends State<PixabayPage> {
  List<PixabayImage> hits = [];

  Future<void> fetchImages(String text) async {
    final apiKey = dotenv.env['PIXABAY_API_KEY'];
    final response = await Dio().get(
      'https://pixabay.com/api/',
      queryParameters: {
        'key': apiKey,
        'q': text,
        'image_type': 'photo',
        'per_page': 100,
      }
    );
    hits = PixabayImage.fromJson(response.data['hits']);
    setState(() {});
  }

  Future<void> shareImage(String url) async {
    Dio().get(url, options: Options(responseType: ResponseType.bytes)).then((
      response,
    ) async {
      final tempDir = await getTemporaryDirectory();
      final imageFile = await File(
        '${tempDir.path}/image.jpg',
      ).writeAsBytes(response.data);
      await SharePlus.instance.share(
        ShareParams(files: [XFile(imageFile.path)]),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    fetchImages('花');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          initialValue: '花',
          decoration: InputDecoration(fillColor: Colors.white, filled: true),
          onFieldSubmitted: (text) => {fetchImages(text)},
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: hits.length,
        itemBuilder: (BuildContext context, int index) {
          final hit = hits[index];
          return InkWell(
            onTap: () => {shareImage(hit.webformatURL)},
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(hit.previewURL, fit: BoxFit.cover),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.thumb_up_alt_outlined, size: 14),
                        Text('${hit.likes}'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
