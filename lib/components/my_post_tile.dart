import 'package:flutter/material.dart';
import 'package:secura/models/post.dart';

//all post will be displayed using this post tile widget
/*we need
  - the post
  - a function for onPostTap (go to that post and see comment)
  - a function for onUserTap (go to that user pfp)
*/
class MyPostTile extends StatefulWidget {
  final Post post;
  final void Function()? onUserTap;
  final void Function()? onPostTap;

  const MyPostTile({
    super.key,
    required this.post,
    required this.onUserTap,
    required this.onPostTap,
  });

  @override
  State<MyPostTile> createState() => _MyPostTileState();
}

class _MyPostTileState extends State<MyPostTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPostTap,
      child: Container(
        //padding outside
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        //padding inside
        padding: EdgeInsets.all(20),
      
        decoration: BoxDecoration(
          //colour of post tile
          color: Theme.of(context).colorScheme.secondary,
      
          //curve corner
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: widget.onUserTap,
              child: Row(
                children: [
                  //profile pic
                  Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.primary,
                  ),
      
                  //name
                  Text(
                    widget.post.name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
      
                  SizedBox(
                    width: 5,
                  ),
      
                  //username handle
                  Text(
                    '@${widget.post.username}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
      
            SizedBox(
              height: 10,
            ),
      
            //message
            Text(
              widget.post.message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
