const exec = require('child_process').exec;
const {command} = require(`../../utils/commands`);

function zoom(data){
  console.log('zoom ->', data)
  key = `zoom_${data.direction}`
  exec(`${command(key)}`)
}

module.exports = {
  zoom: zoom
}
