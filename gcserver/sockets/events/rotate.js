const exec = require('child_process').exec;
const {command} = require(`../../utils/commands`);

function rotate(data){
  console.log('rotate ->', data)
  key = `rotate_${data.direction}`
  exec(`${command(key)}`)
}

module.exports = {
  rotate: rotate
}
