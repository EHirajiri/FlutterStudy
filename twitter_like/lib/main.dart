import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'こんぶ @ Flutter大学',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TweetTile(),
              TweetTile(),
              TweetTile(),
              TweetTile(),
              TweetTile(),
              TweetTile(),
              TweetTile(),
              TweetTile(),
              TweetTile(),
              TweetTile(),
            ],
          ),
        ),
      ),
    );
  }
}

class TweetTile extends StatelessWidget {
  const TweetTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // 上揃えにする
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              'https://cdn.pixabay.com/photo/2024/01/15/21/16/dog-8510901_150.jpg',
            ),
          ),
          SizedBox(width: 8), // 少し隙間を開ける
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('こんぶ @ Flutter大学'),
                  SizedBox(width: 8),
                  Text('2022/05/05'),
                ],
              ),
              SizedBox(height: 4),
              Text('最高でした。'),
              IconButton(
                onPressed: () {}, // ボタンを押したときに実行する内容を書けます。今回は何も実行しません。
                icon: Icon(
                  Icons.favorite_border,
                ), // Icon も Widget のひとつ。Icons. と打つと候補がたくさんでるので好きなアイコンに変更してみよう。
              ),
            ],
          ),
        ],
      ),
    );
  }
}
