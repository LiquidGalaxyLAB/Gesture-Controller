const app = require('express')()
const http = require('http').createServer(app)
const socketio = require('socket.io')(http)
const {connection} = require('./sockets/index.js')
const dotenv = require('dotenv');
const exec = require('child_process').exec;

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

// function openLogos(screen){
//   if(MASTER_IP != 'localhost'){
//     exec(`ssh lg@${MASTER_IP} 'export DISPLAY=:0;mkdir gc-assets;ssh lg@${screen} "export DISPLAY=:0;mkdir gc-assets"'`)
//     exec(`scp ./utils/logos.png lg@${MASTER_IP}:~/gc-assets/`)
//     exec(`ssh lg@${MASTER_IP} 'export DISPLAY=:0;scp ~/gc-assetsr/logos.png lg@lg${screen}:~/gc-assets/'`)
//     exec(`ssh lg@${MASTER_IP} 'export DISPLAY=:0;ssh lg@lg${screen} "export DISPLAY=:0; feh -x -g 400x400 ~/gc-assets/logos.png"'`)
//   } else{
//     exec(`scp utils/logos.png lg@lg${screen}:~/GestureController/`)
//     exec(`ssh lg${screen} "export DISPLAY=:0;feh -x -g 400x400 ~GestureController/logos.png"`)
//   }
// }

http.listen(port,() => {
  console.log(`GC Server listening on port ${port}`)
})
