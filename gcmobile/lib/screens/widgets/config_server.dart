import 'package:flutter/material.dart';
import 'package:gcmobile/services/sockets.dart';

class ConfigServerWidget extends StatefulWidget{
  @override
  _ConfigServerWidgetState createState() => _ConfigServerWidgetState();
}

class _ConfigServerWidgetState extends State<ConfigServerWidget> {

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 300,
          child: TextField(
            controller: address,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.tap_and_play, color: Colors.black54 ,),
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
              child: FlatButton(
                onPressed: () => connect(),
                child: Text(
                  'Connect',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto'
                  )
                ),
                color: Colors.black54,
              )
            ),
            SizedBox(width: 10,),
            Container(
              padding: EdgeInsets.only(top:20),
              width: 150,
              child: FlatButton(
                onPressed: () => disconnect(),
                color: Colors.black54,
                child: Text(
                  'Disconnect',
                  style: TextStyle(
                    color: Colors.white
                  ),
                )
              )
            ),
          ],
        )
      ],
    );
  }
}
