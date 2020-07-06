const app = require('express')()
const http = require('http').createServer(app)
const socketio = require('socket.io')(http)
const {connection} = require('./sockets/index.js')
const dotenv = require('dotenv');

dotenv.config();
const port = process.env.SERVER_PORT;

global.__basedir = __dirname;
global.MASTER_IP = process.env.MASTER_IP;

app.get('/', (req,res)=>{
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "X-Requested-With");
  res.header("Access-Control-Allow-Headers", "Content-Type");
  res.header("Access-Control-Allow-Methods", "PUT, GET, POST, DELETE, OPTIONS");
  res.send('Root route.')
})

socketio.on("connection", connection)


http.listen(port,() => console.log(`GC Server listening on port ${port}`))
