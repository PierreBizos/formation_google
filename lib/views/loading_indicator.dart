import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(93, 142, 155, 1.0),
          body: Center(
        child: SpinKitThreeBounce(color: Colors.white,),
      )),
    );
  }
}