const exec = require('child_process').exec;

function zoom(data, lastState) {
  console.log('data:', data)
  
  const new_data = data.replace(/'/g, '"')
  const obj = JSON.parse(new_data)
  
  console.log('zoom ->', obj.direction)
  console.log('lastState:', lastState.state)
  
  key = `zoom_${obj.direction}`

  if (key == 'zoom_I' && lastState.state == 'equal') {
    return
  }

  if (key == 'zoom_O' && lastState.state == 'minus') {
    return
  }

  if (lastState.state != 'idle') {
    exec(`xdotool windowfocus $(xdotool search --name "Google Earth Pro") keyup ${lastState.state}`)
    lastState.state = 'idle'
  }

  if (key == 'zoom_I' && lastState.state == 'idle') {
    exec('xdotool windowfocus $(xdotool search --name "Google Earth Pro") keydown equal')
    lastState.state = 'equal'
  }

  if (key == 'zoom_O' && lastState.state == 'idle') {
    exec('xdotool windowfocus $(xdotool search --name "Google Earth Pro") keydown minus')
    lastState.state = 'minus'
  }
}

module.exports = {
  zoom: zoom
}
