const app = require('express')()
const http = require('http').createServer(app)
const socketio = require('socket.io')(http)
const {connection} = require('./sockets/index.js')

const port = 8080

global.__basedir = __dirname;

app.get('/', (req,res)=>{
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "X-Requested-With");
  res.header("Access-Control-Allow-Headers", "Content-Type");
  res.header("Access-Control-Allow-Methods", "PUT, GET, POST, DELETE, OPTIONS");
  res.send('Root route.')
})

socketio.on("connection", connection)


http.listen(port,() => console.log(`GC Server listening on port ${port}`))
