import 'package:flutter/material.dart';

Map<int, String> strings = {
  0: 'IDLE',
  1: 'NORTH',
  2: 'SOUTH',
  3: 'WEST',
  4: 'EAST'
};

Map<int, String> terminalColor = {
  0: '\x1B[90m',
  1: '\x1B[94m',
  2: '\x1B[93m',
  3: '\x1B[95m',
  4: '\x1B[96m'
};

Map<int, Color> appColor = {
  0: Colors.black45,
  1: Colors.blue,
  2: Colors.amber,
  3: Colors.pink,
  4: Colors.green
};

Map<int, dynamic> sockets = {
  0: {'event':'idle','data':"{}"},
  1: {'event':'move','data':"{'direction':'N','value':'1'}"},
  2: {'event':'move','data':"{'direction':'S','value':'1'}"},
  3: {'event':'move','data':"{'direction':'W','value':'1'}"},
  4: {'event':'move','data':"{'direction':'E','value':'1'}"}
};
