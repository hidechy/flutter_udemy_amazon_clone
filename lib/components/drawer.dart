import 'package:flutter/material.dart';
import 'shared_prefs.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black54,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 12),
            child: Column(
              children: [
                SizedBox(
                  width: 130,
                  height: 130,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(sharedPreferences!.getString('photoUrl')!),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  sharedPreferences!.getString('name')!,
                  style: const TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                const Divider(height: 10, color: Colors.grey, thickness: 2),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.grey),
                  title: const Text('Home', style: TextStyle(color: Colors.grey)),
                  onTap: () {},
                ),
                const Divider(height: 10, color: Colors.grey, thickness: 2),
                ListTile(
                  leading: const Icon(Icons.reorder, color: Colors.grey),
                  title: const Text('My Orders', style: TextStyle(color: Colors.grey)),
                  onTap: () {},
                ),
                const Divider(height: 10, color: Colors.grey, thickness: 2),
                ListTile(
                  leading: const Icon(Icons.picture_in_picture_alt_rounded, color: Colors.grey),
                  title: const Text('Not Yet Received Order', style: TextStyle(color: Colors.grey)),
                  onTap: () {},
                ),
                const Divider(height: 10, color: Colors.grey, thickness: 2),
                ListTile(
                  leading: const Icon(Icons.access_time, color: Colors.grey),
                  title: const Text('History', style: TextStyle(color: Colors.grey)),
                  onTap: () {},
                ),
                const Divider(height: 10, color: Colors.grey, thickness: 2),
                ListTile(
                  leading: const Icon(Icons.search, color: Colors.grey),
                  title: const Text('Search', style: TextStyle(color: Colors.grey)),
                  onTap: () {},
                ),
                const Divider(height: 10, color: Colors.grey, thickness: 2),
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.grey),
                  title: const Text('Sign Out', style: TextStyle(color: Colors.grey)),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
