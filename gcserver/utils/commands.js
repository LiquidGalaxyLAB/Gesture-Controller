const map = {
  move_N: 'Up',
  move_S: 'Down',
  move_W: 'Left',
  move_E: 'Right',
  rotate_L: 'ctrl+Left',
  rotate_R: 'ctrl+Right',
  zoom_I: 'equal',
  zoom_O: 'minus',
  planet: 'planet=',
  flyto: 'search='
}

function command(key){
  if(MASTER_IP != 'localhost')
    return `ssh lg@${MASTER_IP} 'export DISPLAY=:0;xdotool key --delay 500 ${map[key]}'`
  else
    return `xdotool key --delay 500 ${map[key]}`
}

function query(operation, data){
  if(MASTER_IP != 'localhost')
    return `ssh lg@${MASTER_IP} 'export DISPLAY=:0;echo '${map[operation]+data}' > /tmp/query.txt'`
  else
    return `echo '${map[operation]+data}' > /tmp/query.txt'`
}

module.exports = {
  command: command,
  query: query
}
