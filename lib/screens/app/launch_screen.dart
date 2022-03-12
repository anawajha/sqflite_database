import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_database/provider/note_provider.dart';

class LaunchScreen extends StatefulWidget {

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context,'/main_screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Notes',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
          color: Colors.black,
        ),),
      ),
    );
  }
}
