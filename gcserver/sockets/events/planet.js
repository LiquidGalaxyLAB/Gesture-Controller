const exec = require('child_process').exec;

function planet(data, lastState) {
  console.log('data:', data)
 
  const new_data = data.replace(/'/g, '"')
  const obj = JSON.parse(new_data)
  
  console.log('change planet ->', obj.direction)
  console.log('lastState:', lastState.state)

  if (lastState.state != 'idle') {
    exec(`xdotool windowfocus $(xdotool search --name "Google Earth Pro") keyup ${lastState.state}`)
    lastState.state = 'idle'
  }

  if (lastState.state == 'idle') {
    exec(`xdotool windowfocus $(xdotool search --name "Google Earth Pro") && echo 'planet=${obj.direction}' > /tmp/query.txt`)
  }
}

module.exports = {
  planet: planet
}
