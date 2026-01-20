import 'package:chat/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(title: const Text('マイページ')),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL!),
              radius: 40,
            ),
            Text(
              user.displayName!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              // ユーザー ID
              child: Text('ユーザーID：${user.uid}'),
            ),
            Align(
              alignment: Alignment.centerLeft,
              // 登録日
              child: Text('登録日：${user.metadata.creationTime!}'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                await GoogleSignIn.instance.signOut();
                await FirebaseAuth.instance.signOut();
                navigator.pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignInPage();
                    },
                  ),
                  (_) => false,
                );
              },
              child: const Text('ログアウト'),
            ),
          ],
        ),
      ),
    );
  }
}
