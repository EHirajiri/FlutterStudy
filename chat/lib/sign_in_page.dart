import 'package:chat/chat_page.dart';
import 'package:chat/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize();
    final googleUser = await googleSignIn.authenticate();
    final authorization = await googleSignIn.authorizationClient
        .authorizationForScopes(['profile', 'email']);

    final credential = GoogleAuthProvider.credential(
      accessToken: authorization?.accessToken,
      idToken: googleUser.authentication.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GoogleSignIn')),
      body: Center(
        child: ElevatedButton(
          child: const Text('GoogleSignIn'),
          onPressed: () async {
            final navigator = Navigator.of(context);
            await signInWithGoogle();
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) {
                  return const ChatPage();
                },
              ),
              (route) => false,
            );
          },
        ),
      ),
    );
  }
}

final postsReference = FirebaseFirestore.instance
    .collection('posts')
    .withConverter<Post>(
      // <> ここに変換したい型名をいれます。今回は Post です。
      fromFirestore: ((snapshot, _) {
        // 第二引数は使わないのでその場合は _ で不使用であることを分かりやすくしています。
        return Post.fromFirestore(
          snapshot,
        ); // 先ほど定期着した fromFirestore がここで活躍します。
      }),
      toFirestore: ((value, _) {
        return value.toMap(); // 先ほど適宜した toMap がここで活躍します。
      }),
    );
