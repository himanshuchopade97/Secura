import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secura/components/drawer_tile.dart';
import 'package:secura/components/input_alert_box.dart';
import 'package:secura/components/my_post_tile.dart';
import 'package:secura/helper/navigate_pages.dart';
import 'package:secura/models/post.dart';
import 'package:secura/pages/pofile_page.dart';
import 'package:secura/pages/settings_page.dart';
import 'package:secura/services/auth/auth_service.dart';
import 'package:secura/services/database/database_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  //access auth service

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = AuthService();

  //executes the listened data to firebase & vice versa
  late final databaseProvider = Provider.of<DatabaseProvider>(context, listen: false); 
  
  late final listeningProvider =
      Provider.of<DatabaseProvider>(context); //only listens to changes

  void logout() {
    _auth.logout();
  }

  final _messageCntroller = TextEditingController();

  //on startup, load all posts
  @override
  void initState() {
    super.initState();
    loadAllPosts();
  }

  Future<void> loadAllPosts() async {
    await databaseProvider.loadAllPosts(); //this load all posts function from database provider
  }

  void _openPostMessageBox() {
    showDialog(
      context: context,
      builder: (context) => InputAlertBox(
        textController: _messageCntroller,
        hintText: "Whats on your mind?",
        onPressed: () async {
          //post message
          await postMessage(_messageCntroller.text);
        },
        onPressedText: "Post",
      ),
    );
  }

  //user wants to post message
  Future<void> postMessage(String message) async {
    await databaseProvider.postMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: SafeArea(
          child: Column(
            children: [
              //app icon
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Icon(
                  Icons.person,
                  size: 72,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),

              Divider(
                indent: 25,
                endIndent: 25,
                color: Theme.of(context).colorScheme.onSecondary,
              ),

              const SizedBox(
                height: 10,
              ),
              // home list tile
              DrawerTile(
                title: "H O M E",
                icon: Icons.home,
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              //profile list tile
              DrawerTile(
                title: "P R O F I L E",
                icon: Icons.person,
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProfilePage(uid: _auth.getCurrentUid()),
                    ),
                  );
                },
              ),

              // search list tile

              //setting list tile
              DrawerTile(
                title: "S E T T I N G S",
                icon: Icons.settings,
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
              ),

              Spacer(),

              DrawerTile(
                title: "L O G O U T",
                icon: Icons.logout,
                onTap: () {
                  logout();
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("H O M E"),
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
      ),

      //floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openPostMessageBox();
        },
        child: Icon(Icons.add),
      ),

      //body : list of all posts
      body: _buildPostList(listeningProvider.allPosts),
    );
  }

  Widget _buildPostList(List<Post> posts) {
    return posts.isEmpty
        ? Center(child: Text("Nothing here"))
        : ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              //get each post
              final post = posts[index];

              //return as post tile ui
              return MyPostTile(
                post: post,
                onUserTap: () => goUserPage(context, post.uid),
                onPostTap: () => goPostPage(context, post),
              );
            },
          );
  }
}
