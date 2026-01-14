# Flutter学習

## 開発環境

- MacOS: 26.1
- Visual Studio Code: 1.107.0
- Flutter: 3.38.5
- Dart: 3.10.4
- Android SDK: 36.1.0
- Xcode: 26.2

## 学習内容

- [Flutterの教科書 by Flutter大学](https://zenn.dev/flutteruniv/books/flutter-textbook/viewer/index)


## 成果物

### [じゃんけんアプリ](./janken/)
- 学習項目
  - [Chapter 08
変数・関数・条件分岐の基礎『じゃんけん』](https://zenn.dev/flutteruniv/books/flutter-textbook/viewer/make-janken-game)
  - 実践課題Aまで
- 参考書からの改善点
  - 出す手(グーチョキパー)をenumとして定義して別ファイルに切り出した
  - コンピュータがランダムに出す手や勝敗判定は出す手の定義に含めるよう修正した
  - 勝敗の文字列をenumとして定義して別ファイルに切り出した
  - 出す手は３つあるのでコンポーネントがして別ファイルに切り出した
  - アクセシビリティ対応(途中)
- 動作確認
  - 端末: iPhone 16e 26.2(Simulator)
  - <video src="./images/janken_app_iPone16e.mp4" controls="true" />


