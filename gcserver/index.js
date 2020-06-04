const app = require('express')()
const http = require('http').createServer(app)
const socketio = require('socket.io')(http)

const port = 8080

app.get('/', (req,res)=>{
  res.send('Root route.')
})

socketio.on("connection", (userSocket) => {
  userSocket.on("send_message", (data) => {
    userSocket.broadcast.emit("receive_message",data)
  })
})

app.listen(port,() => console.log(`GC Server listening on port ${port}`))
