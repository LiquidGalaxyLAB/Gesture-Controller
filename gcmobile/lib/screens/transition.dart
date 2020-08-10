import 'package:flutter/material.dart';
import 'package:gcmobile/screens/widgets/logos.dart';

class TransitionScreen extends StatefulWidget{
  @override
  _TransitionScreenState createState() => _TransitionScreenState();
}

class _TransitionScreenState extends State<TransitionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LogosWidget()
      ),
    );
  }
}
