import 'package:flutter/material.dart';

class NavigationDrawerMenu extends StatelessWidget {
  const NavigationDrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      color: Colors.blue.shade700,
      padding:
          EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 24),
      child: const Column(children: [
        CircleAvatar(
          radius: 52,
          backgroundImage:  AssetImage("assets/images/logo_dc.png"),
        ),
        SizedBox(height: 12),
        Text(
          "Defensa Civil",
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
        Text(
          "Bienvenido/a",
          style: TextStyle(fontSize: 16, color: Colors.white),
        )
      ]),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text("Home" ),
              onTap: () {},

            ),
            ListTile(
              leading: const Icon(Icons.favorite_outline),
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.link_outlined),
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info_outlined),
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text("Home"),
              onTap: () {},
            ),
            const Divider(
              color: Colors.black54,
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text("Home"),
              onTap: () {},
            ),
          ],
        ));
  }
}
