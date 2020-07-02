const exec = require('child_process').exec;
const {move} = require('./events/move.js')
const fs = require('fs')

var controller = {
  state: 'idle',
  timer: false
}

function connection(userSocket){
  const scripts = {
    'move_N':`${__basedir}/scripts/move_north.sh`
  }

  console.log("Client connected!")

  userSocket.on("move", (data) => move(data, controller))

  userSocket.on("rotate", (data) => {
      console.log('rotate ->', data)
  })

  userSocket.on("zoom", (data) => {
      console.log('zoom ->', data)
  })

  userSocket.on("planet", (data) => {
      console.log('change planet')
  })

  userSocket.on("record", (data) => {
      console.log('Record recieved...')
      fs.writeFile('outputs/myjsonfile.json', JSON.stringify(data), 'utf8', ()=>{});
  })
}

module.exports = {
  connection: connection,
  controller: controller
}
