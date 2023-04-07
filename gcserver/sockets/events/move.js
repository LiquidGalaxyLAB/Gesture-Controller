const exec = require('child_process').exec;

function move(data, lastState) {
  console.log('data:', data)
  
  const new_data = data.replace(/'/g, '"')
  const obj = JSON.parse(new_data)
  
  console.log('move ->', obj.direction)
  console.log('lastState:', lastState.state)
  
  key = `move_${obj.direction}`

  if (key == 'move_N' && lastState.state == 'Up') {
    return
  }

  if (key == 'move_S' && lastState.state == 'Down') {
    return
  }

  if (key == 'move_W' && lastState.state == 'Left') {
    return
  }

  if (key == 'move_E' && lastState.state == 'Right') {
    return
  }
  
  if (lastState.state != 'idle') {
    exec(`xdotool windowfocus $(xdotool search --name "Google Earth Pro") keyup ${lastState.state}`)
    lastState.state = 'idle'
  }
  
  if (key == 'move_N' && lastState.state == 'idle') {
    exec(`xdotool windowfocus $(xdotool search --name "Google Earth Pro") keydown Up`)
    lastState.state = 'Up'
  }
  
  if (key == 'move_S' && lastState.state == 'idle') {
    exec(`xdotool windowfocus $(xdotool search --name "Google Earth Pro") keydown Down`)
    lastState.state = 'Down'
  }
  
  if (key == 'move_W' && lastState.state == 'idle') {
    exec(`xdotool windowfocus $(xdotool search --name "Google Earth Pro") keydown Left`)
    lastState.state = 'Left'
  }
  
  if (key == 'move_E' && lastState.state == 'idle') {
    exec(`xdotool windowfocus $(xdotool search --name "Google Earth Pro") keydown Right`)
    lastState.state = 'Right'
  }
}

module.exports = {
  move: move
}
