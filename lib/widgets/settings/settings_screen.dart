import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text('Settings'),
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.info),
                title: Text('About us'),
                trailing: Icon(Icons.navigate_next),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
