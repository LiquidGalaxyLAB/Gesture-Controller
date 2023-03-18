const exec = require('child_process').exec;

function idle(data, lastState) {
  console.log('data:', data)
  console.log('lastState', lastState.state)
  
  if (lastState.state == 'idle') {
    return
  }
  
  exec(`xdotool windowfocus $(xdotool search --name "Google Earth Pro") keyup ${lastState.state}`)
  lastState.state = 'idle'
}

module.exports = {
  idle: idle
}
