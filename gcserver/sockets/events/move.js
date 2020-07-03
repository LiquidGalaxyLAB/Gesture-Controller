const exec = require('child_process').exec;

function move(data, controller){
  const scripts = {
    'move_N':`${__basedir}/scripts/move_north.sh`,
    'move_S':`${__basedir}/scripts/move_south.sh`,
    'move_W':`${__basedir}/scripts/move_west.sh`,
    'move_E':`${__basedir}/scripts/move_east.sh`,
  }

  console.log('move ->', data)
  if(controller.state!=data.direction){
    exec(`bash ${scripts[`move_${data.direction}`]} ${MASTER_IP}`)
    controller.state = data.direction
  } else if(controller.timer == false){
    controller.timer = true
    setTimeout(()=>{
      exec(`bash ${scripts[`move_${data.direction}`]}`)
      controller.timer = false
    },1000)
  }
}

module.exports = {
  move: move
}
