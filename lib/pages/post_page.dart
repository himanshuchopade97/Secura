import 'package:flutter/material.dart';
import 'package:secura/models/post.dart';

/*
  this page displays :
    - individual post
    - comment on post
 */

class PostPage extends StatefulWidget {
  final Post post;
  const PostPage({
    super.key,
    required this.post,
  });

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.message),
      ),
    );
  }
}
