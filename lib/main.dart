import 'package:flutter/material.dart';
import 'package:async/async.dart';



void main(){
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,

  ));
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("\$ Money Convert \$"),
        backgroundColor: Colors.red,
        centerTitle: true,
        ),
     // body: FutureBuilder <Map> (builder: null),
    );
  }
}
