const exec = require('child_process').exec;

function move(data){
  const scripts = {
    'move_N':`${__basedir}/scripts/move_north.sh`
  }

  console.log('move ->', data)
  exec(`bash ${scripts[`move_${data.direction}`]}`)
}

module.exports = {
  move: move
}
