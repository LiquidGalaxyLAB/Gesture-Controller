const exec = require('child_process').exec;
const {command} = require(`../../utils/commands`);

function planet(data){
  console.log('change planet ->', data)
  operation = 'planet'
  exec(`${query(operation, data.direction)}`)
}

module.exports = {
  planet: planet
}
