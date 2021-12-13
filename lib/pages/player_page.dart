import 'package:flutter/material.dart';

class PlayerDetails extends StatelessWidget {
  const PlayerDetails({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)
          ),
        ),
      )
    );
  }
}