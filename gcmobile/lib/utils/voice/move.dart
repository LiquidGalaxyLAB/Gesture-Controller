Map<String, dynamic> move = {
  'value': 1,
  'variations': [
    'move',
  ],
  'options': [
    _north,
     _south,
     _west,
    _east
  ]
};

Map<String, dynamic> short_north = {
  'value': 1,
  'variations': [
    'north',
  ],
  'options': []
};

Map<String, dynamic> short_south = {
  'value': 2,
  'variations': [
    'south',
  ],
  'options': []
};

Map<String, dynamic> short_west = {
  'value': 3,
  'variations': [
    'west',
  ],
  'options': []
};

Map<String, dynamic> short_east = {
  'value': 4,
  'variations': [
    'east',
  ],
  'options': []
};

List<String> _north = [
  'north',
  'up'
];

List<String> _south = [
  'south',
  'down'
];

List<String> _west = [
  'west',
  'left'
];

List<String> _east = [
  'east',
  'right'
];
