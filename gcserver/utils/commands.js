const map = {
  move_N: 'Up',
  move_S: 'Down',
  move_W: 'Left',
  move_E: 'Right'
}

function command(key){
  if(MASTER_IP != 'localhost')
    return `ssh lg@${MASTER_IP} 'export DISPLAY=:0;xdotool key --delay 500 ${map[key]}'`
  else
    return `xdotool key --delay 500 ${map[key]}`
}

module.exports = {
  command: command
}
