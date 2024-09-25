import 'package:flutter/material.dart';
import 'package:secura/models/post.dart';
import 'package:secura/pages/pofile_page.dart';
import 'package:secura/pages/post_page.dart';

//go to user page
void goUserPage(BuildContext context, String uid) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProfilePage(uid: uid),
    ),
  );
}

//go to post page
void goPostPage(BuildContext context, Post post){
  //navigate to post page
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PostPage(post: post,),
    ),
  );
}
