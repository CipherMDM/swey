import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';


void main()=>runApp(View());


class View extends StatefulWidget {
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);
   
    return MaterialApp(
      
      theme: ThemeData(
        
        primaryColor: Colors.redAccent
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}