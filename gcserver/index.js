const app = require('express')()

const port = 8080

app.get('/', (req,res)=>{
  res.send('Root route.')
})

app.listen(port,() => console.log(`GC Server listening on port ${port}`))
