import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';
import 'package:secura/models/post.dart';
import 'package:secura/services/auth/auth_service.dart';
import 'package:secura/services/database/database_provider.dart';

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
  //provider
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);
  late final listeningProvider = Provider.of<DatabaseProvider>(context);

  //user tapped like or unlike
  void _toggleLikePost() async {
    try {
      await databaseProvider.toggleLike(widget.post.id);
    } catch (e) {
      print(e);
    }
  }

  void _showOptions() {
    //check if post is owned by user or not
    String currentUid = AuthService().getCurrentUid();
    final bool isOwnPost = widget.post.uid == currentUid;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              if (isOwnPost)
                // delete button
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text("Delete"),
                  onTap: () async {
                    Navigator.pop(context);

                    //handle delete action
                    await databaseProvider.deletePost(widget.post.id);
                  },
                )
              else ...[
                ListTile(
                  //report post
                  leading: const Icon(Icons.flag),
                  title: const Text("Report"),
                  onTap: () {
                    Navigator.pop(context);

                    //handle report
                  },
                ),

                //block user
                ListTile(
                  //report post
                  leading: const Icon(Icons.block),
                  title: const Text("Block User"),
                  onTap: () {
                    Navigator.pop(context);

                    //handle report
                  },
                ),
              ],

              // cancel button
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text("Cancel"),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }

  void _showOptions2() {
    String currentUid = AuthService().getCurrentUid();
    final bool isOwnPost = widget.post.uid == currentUid;
    showPopover(
      context: context,
      bodyBuilder: (context) {
        return Wrap(
          children: [
            //delete button
            if (isOwnPost)
              // delete button
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text("Delete"),
                onTap: () async {
                  Navigator.pop(context);

                  //handle delete action
                  await databaseProvider.deletePost(widget.post.id);
                },
              )
            else ...[
              ListTile(
                //report post
                leading: const Icon(Icons.flag),
                title: const Text("Report"),
                onTap: () {
                  Navigator.pop(context);

                  //handle report
                },
              ),

              //block user
              ListTile(
                //report post
                leading: const Icon(Icons.block),
                title: const Text("Block User"),
                onTap: () {
                  Navigator.pop(context);

                  //handle report
                },
              ),
            ],
            //cancel button
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text("Cancel"),
              onTap: () {},
            )
          ],
        );
      },
      width: 180,
      // height: 180,
      direction: PopoverDirection.bottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    //does the current user like the post
    bool likedByCurrentUser =
        listeningProvider.isPostLikedByCurrentUser(widget.post.id);

    return GestureDetector(
      onTap: widget.onPostTap,
      onLongPress: _showOptions2,
      child: Container(
        //padding outside
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        //padding inside
        padding: const EdgeInsets.all(20),

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

                  const SizedBox(width: 5),

                  //username handle
                  Text(
                    '@${widget.post.username}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),

                  const Spacer(),

                  GestureDetector(
                    onTap: () => _showOptions(),
                    child: Icon(Icons.more_horiz),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            //message
            Text(
              widget.post.message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),

            const SizedBox(height: 20),

            //buttons for like and comment
            Row(
              children: [
                //like
                GestureDetector(
                  onTap: _toggleLikePost,
                  child: likedByCurrentUser ? Icon(Icons.favorite, color: Colors.red) :Icon(Icons.favorite_border, color: Colors.grey) ,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
