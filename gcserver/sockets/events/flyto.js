const exec = require('child_process').exec;
const {query} = require(`../../utils/commands`);

function flyto(data){
  console.log('fly to ->', data)
  operation = 'flyto'
  exec(`${query(operation, data.direction)}`)
}

module.exports = {
  flyto: flyto
}
