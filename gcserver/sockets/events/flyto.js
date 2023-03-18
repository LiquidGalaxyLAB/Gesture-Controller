const exec = require('child_process').exec;

function flyto(data, lastState) {
  console.log('data:', data)
  
  data = data.replace('}', '')
  const new_data = data.replace(/'/g, '"')
  const obj = JSON.parse(new_data)
  
  console.log('fly to ->', obj.direction)
  console.log('lastState', lastState.state)

  if (lastState.state != 'idle') {
    exec(`xdotool windowfocus $(xdotool search --name "Google Earth Pro") keyup ${lastState.state}`)
    lastState.state = 'idle'
  }

  if (lastState.state == 'idle') {
    exec(`xdotool windowfocus $(xdotool search --name "Google Earth Pro") && echo 'search=${obj.direction}' > /tmp/query.txt`)
  }
}

module.exports = {
  flyto: flyto
}
