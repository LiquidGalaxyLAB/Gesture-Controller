const exec = require('child_process').exec;

function move(data){
  const scripts = {
    'move_N':`${__basedir}/scripts/move_north.sh`,
    'move_S':`${__basedir}/scripts/move_south.sh`,
    'move_W':`${__basedir}/scripts/move_west.sh`,
    'move_E':`${__basedir}/scripts/move_east.sh`,
  }

  console.log('move ->', data)
  exec(`bash ${scripts[`move_${data.direction}`]}`)
}

module.exports = {
  move: move
}
