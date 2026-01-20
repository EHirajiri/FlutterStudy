import 'package:chat/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(post.posterImageUrl)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      post.posterName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      DateFormat('MM/dd HH:mm').format(post.createdAt.toDate()),
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color:
                              FirebaseAuth.instance.currentUser?.uid ==
                                  post.posterId
                              ? Colors.amber[100]
                              : Colors.blue[100],
                        ),
                        child: Text(post.text),
                      ),
                    ),
                    if (FirebaseAuth.instance.currentUser?.uid == post.posterId)
                      SizedBox(
                        width: 96,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: TextFormField(
                                        initialValue: post.text,
                                        autofocus: true,
                                        onFieldSubmitted: (newText) {
                                          post.reference.update({
                                            'text': newText,
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                post.reference.delete();
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      )
                    else
                      const SizedBox(width: 96),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
