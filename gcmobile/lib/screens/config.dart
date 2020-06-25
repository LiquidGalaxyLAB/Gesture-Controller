import 'package:flutter/material.dart';
import 'package:gcmobile/services/sockets.dart';

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
    address.text = Socket.domain;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 300,
              child: TextField(
                controller: address,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.tap_and_play),
                  hintText: '192.168.0.152:8080',
                  labelText: 'Server address'
                ),
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top:20),
                  width: 150,
                  child: RaisedButton(
                    onPressed: () => connect(),
                    child: Text('Connect')
                  )
                ),
                SizedBox(width: 10,),
                Container(
                  padding: EdgeInsets.only(top:20),
                  width: 150,
                  child: RaisedButton(
                    onPressed: () => disconnect(),
                    child: Text('Disconnect')
                  )
                ),
              ],
            )
          ],
        )
      )
    );
  }
}
