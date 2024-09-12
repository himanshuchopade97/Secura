import 'package:flutter/material.dart';
import 'package:secura/components/drawer_tile.dart';
import 'package:secura/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                onTap: () {},
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
                      builder: (context) => SettingsPage(),
                    ),
                  );
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
    );
  }
}
