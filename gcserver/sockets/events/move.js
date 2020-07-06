const exec = require('child_process').exec;
const {command} = require(`../../utils/commands`);

function move(data, controller){
  console.log('move ->', data)
  key = `move_${data.direction}`
  exec(`${command(key)}`)

  // if(controller.state!=data.direction){
  //   exec(`bash ${scripts[`move_${data.direction}`]} ${MASTER_IP}`)
  //   controller.state = data.direction
  // } else if(controller.timer == false){
  //   controller.timer = true
  //   setTimeout(()=>{
  //     exec(`bash ${scripts[`move_${data.direction}`]}`)
  //     controller.timer = false
  //   },1000)
  // }
}

module.exports = {
  move: move
}
