const exec = require('child_process').exec;
const {command} = require(`../../utils/commands`);

function idle(data, lastState){
  console.log('idle')
  if(lastState.state!=data)
    exec(`${command('idle',lastState.state)}`)
  lastState.state=''
}

module.exports = {
  idle: idle
}
