import 'package:flutter/material.dart';
import 'package:gcmobile/services/sockets.dart';

class ConfigServerWidget extends StatefulWidget {
  @override
  _ConfigServerWidgetState createState() => _ConfigServerWidgetState();
}

class _ConfigServerWidgetState extends State<ConfigServerWidget> {
  final address = new TextEditingController();
  final socket = Socket();
  bool state;
  String ip;

  refresh(){
    setState(() {
        state = Socket.state;
        ip = Socket.domain;
    });
  }

  connect() async {
    await socket.initialize(address.text, refresh);
    Navigator.pop(context);
  }

  disconnect() async {
    await socket.close();
    Navigator.pop(context);
  }

  initState(){
    super.initState();
    state = Socket.state;
    ip = Socket.domain;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Server Informations',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 16
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Status: ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black54,
                      fontSize: 15
                    )
                  ),
                ),
                statusWidget(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Address: ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black54,
                      fontSize: 15
                    )
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    ip ?? '',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black54,
                      fontSize: 15
                    )
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              width: double.infinity,
              height: 28,
              child: OutlineButton(
                onPressed: () => _showMyDialog(),
                child: Text('EDIT',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black54,
                    fontSize: 15
                  )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget statusWidget(){
    if(state == false){
      return Align(
        alignment: Alignment.center,
        child: Text(
          'disconnected',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black54,
            fontSize: 15
          )
        ),
      );
    }
    return Align(
      alignment: Alignment.center,
      child: Text(
        'connected',
        style: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.green,
          fontSize: 15
        )
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Server Address',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 18
            )
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: 300,
                  child: TextField(
                    controller: address,
                    decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.tap_and_play,),
                      hintText: '192.168.0.152:8080',
                      labelText: 'Host'
                    ),
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top:20),
                      width: 110,
                      child: FlatButton(
                        onPressed: () => disconnect(),
                        child: Text(
                          'Disconnect',
                          style: TextStyle(
                            color: Colors.black
                          ),
                        )
                      )
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.only(top:20),
                      width: 110,
                      child: FlatButton(
                        onPressed: () => connect(),
                        child: Text(
                          'Connect',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto'
                          )
                        ),
                      )
                    ),
                  ],
                )
              ],
            ),
          ),
          // actions: <Widget>[
          //   FlatButton(
          //     child: Text('Connect'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          //   Spacer(),
          //   FlatButton(
          //     child: Text('Disconnect'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }
}
