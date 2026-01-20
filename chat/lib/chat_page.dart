import 'package:chat/my_page.dart';
import 'package:chat/post.dart';
import 'package:chat/post_widget.dart';
import 'package:chat/sign_in_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();

  Future<void> sendPost(String text) async {
    final newDocumentReference = postsReference.doc();
    final user = FirebaseAuth.instance.currentUser!;
    final newPost = Post(
      text: text,
      createdAt: Timestamp.now(),
      posterName: user.displayName!,
      posterImageUrl: user.photoURL!,
      posterId: user.uid,
      reference: newDocumentReference,
    );
    newDocumentReference.set(newPost);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('チャット'),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const MyPage();
                    },
                  ),
                );
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  FirebaseAuth.instance.currentUser!.photoURL!,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Post>>(
                // stream プロパティに snapshots() を与えると、コレクションの中のドキュメントをリアルタイムで監視することができます。
                stream: postsReference.orderBy('createdAt').snapshots(),
                // ここで受け取っている snapshot に stream で流れてきたデータが入っています。
                builder: (context, snapshot) {
                  // docs には Collection に保存されたすべてのドキュメントが入ります。
                  // 取得までには時間がかかるのではじめは null が入っています。
                  // null の場合は空配列が代入されるようにしています。
                  final docs = snapshot.data?.docs ?? [];
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      // data() に Post インスタンスが入っています。
                      // これは withConverter を使ったことにより得られる恩恵です。
                      // 何もしなければこのデータ型は Map になります。
                      final post = docs[index].data();
                      return PostWidget(post: post);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  // 未選択時の枠線
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.amber),
                  ),
                  // 選択時の枠線
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.amber, width: 2),
                  ),
                  fillColor: Colors.amber[50],
                  filled: true,
                ),
                onFieldSubmitted: (text) {
                  sendPost(text);
                  controller.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
