import 'package:flutter/material.dart';
import 'package:gcmobile/services/sockets.dart';
import 'package:gcmobile/screens/widgets/config_server.dart';
import 'package:gcmobile/services/router.dart';

class ConfigScreen extends StatefulWidget {

  @override
  _ConfigScreen createState() => new _ConfigScreen();
}

class _ConfigScreen extends State<ConfigScreen>{

  final address = new TextEditingController();


  connect() async{
    await Socket.initialize(address.text);
    setState(() {});
  }

  disconnect() async{
    await Socket.close();
  }

  @override
  Widget build(BuildContext context) {
    Router.state = 'config';
    address.text = Socket.domain;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ConfigServerWidget(),
          ],
        )
      )
    );
  }
}
