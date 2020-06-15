const exec = require('child_process').exec;
const {move} = require('./events/move.js')

function connection(userSocket){
  const scripts = {
    'move_N':`${__basedir}/scripts/move_north.sh`
  }

  console.log("Client connected!")

  userSocket.on("move", move)

  userSocket.on("rotate", (data) => {
      console.log('rotate ->', data)
  })

  userSocket.on("zoom", (data) => {
      console.log('zoom ->', data)
  })

  userSocket.on("planet", (data) => {
      console.log('change planet')
  })
}

module.exports = {
  connection: connection
}
