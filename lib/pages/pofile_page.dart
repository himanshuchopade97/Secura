import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secura/components/input_alert_box.dart';
import 'package:secura/components/my_bio_box.dart';
import 'package:secura/components/my_post_tile.dart';
import 'package:secura/helper/navigate_pages.dart';
import 'package:secura/models/user.dart';
import 'package:secura/services/auth/auth_service.dart';
import 'package:secura/services/database/database_provider.dart';

//profile page for a given UID

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //providers
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  //user info
  UserProfile? user;
  String currentUserId = AuthService().getCurrentUid();

  final bioTextController = TextEditingController();

  //loading...
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    //loading user info
    loadUser();
  }

  Future<void> loadUser() async {
    user = await databaseProvider.userProfile(widget.uid);

    //finished loading
    setState(() {
      _isLoading = false;
    });
  }

  void _showEditBioBox() {
    showDialog(
      context: context,
      builder: (context) => InputAlertBox(
        textController: bioTextController,
        hintText: "Edit bio...",
        onPressed: saveBio,
        onPressedText: "Save",
      ),
    );
  }

  //save bio
  Future<void> saveBio() async {
    setState(() {
      //start loading
      _isLoading = true;
    });

    await databaseProvider.updateBio(bioTextController.text);
    await loadUser();
    setState(() {
      _isLoading = false;
    });
  }

  //build ui
  @override
  Widget build(BuildContext context) {
    //get user posts
    final allUserPosts = listeningProvider.filterUserPosts(widget.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isLoading ? '' : user!.name,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 25),
          //pfp
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(25),
              ),
              padding: EdgeInsets.all(25),
              child: Icon(
                Icons.person,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          const SizedBox(height: 25),
          //username handle
          Center(
            child: Text(
              _isLoading ? "" : '@${user!.username}',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 18),
            ),
          ),

          const SizedBox(height: 25),
          //profile stats

          //follow unfollow button

          //edit bio
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Bio",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: _showEditBioBox,
                  child: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          //bio box
          MyBioBox(text: _isLoading ? '...' : user!.bio),

          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25),
            child: Text(
              "Posts",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),

          //list posts
          allUserPosts.isEmpty
              ? Center(
                  child: Text("No Posts yet..."),
                )
              : ListView.builder(
                  itemCount: allUserPosts.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    //get individual post
                    final post = allUserPosts[index];
                    return MyPostTile(
                      post: post,
                      onUserTap: () {},
                      onPostTap: () => goPostPage(context, post),
                    );
                  },
                )
        ],
      ),
    );
  }
}
