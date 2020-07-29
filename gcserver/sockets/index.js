const exec = require('child_process').exec;
const fs = require('fs')
const {move} = require('./events/move.js')
const {rotate} = require('./events/rotate.js')
const {zoom} = require('./events/zoom.js')
const {flyto} = require('./events/flyto.js')
const {planet} = require('./events/planet.js')


function connection(userSocket){
  console.log("Client connected!")
  userSocket.on("move", move)
  userSocket.on("rotate", rotate)
  userSocket.on("zoom", zoom)
  userSocket.on("planet", planet)
  userSocket.on("flyto", flyto)
}

module.exports = {
  connection: connection
}
