const exec = require('child_process').exec;

function rotate(data, lastState) {
  console.log('data:', data)
  
  const new_data = data.replace(/'/g, '"')
  const obj = JSON.parse(new_data)
  
  console.log('rotate ->', obj.direction)
  console.log('lastState:', lastState.state)
  
  key = `rotate_${obj.direction}`

  if (key == 'rotate_L' && lastState.state == 'ctrl+Left') {
    return
  }

  if (key == 'rotate_R' && lastState.state == 'ctrl+Right') {
    return
  }

  if (lastState.state != 'idle') {
    exec(`xdotool windowfocus $(xdotool search --name "Google Earth Pro") keyup ${lastState.state}`)
    lastState.state = 'idle'
  }

  if (key == 'rotate_L' && lastState.state == 'idle') {
    exec('xdotool windowfocus $(xdotool search --name "Google Earth Pro") keydown ctrl+Left')
    lastState.state = 'ctrl+Left'
  }
  
  if (key == 'rotate_R' && lastState.state == 'idle') {
    exec('xdotool windowfocus $(xdotool search --name "Google Earth Pro") keydown ctrl+Right')
    lastState.state = 'ctrl+Right'
  }
}

module.exports = {
  rotate: rotate
}
