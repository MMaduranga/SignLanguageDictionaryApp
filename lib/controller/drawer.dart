import 'package:flutter/material.dart';

class CommonDrawer{

  Widget funDrawer(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration:const BoxDecoration(
              color: Colors.lightBlueAccent,
            ),
            child: IconButton(
              onPressed: () {},
              icon:const Icon(Icons.arrow_back),
              alignment: Alignment.topLeft,
            ),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}