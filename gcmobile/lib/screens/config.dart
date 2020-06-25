import 'package:flutter/material.dart';
import 'package:gcmobile/services/sockets.dart';

class ConfigScreen extends StatelessWidget {

  final address = new TextEditingController();


  connect(){
    Socket.initialize('http://' + address.text);
  }

  @override
  Widget build(BuildContext context) {
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
            Container(
              padding: EdgeInsets.only(top:20),
              width: 300,
              child: RaisedButton(
                onPressed: () => connect(),
                child: Text('Connect')
              )
            ),
          ],
        )
      )
    );
  }
}
