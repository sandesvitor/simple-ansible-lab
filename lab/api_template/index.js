const express = require("express")
const cors = require("cors")
const bodyParser = require("body-parser")
const app = express()

let request = []

app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())
app.use(cors())

app.post("/", (req, res) => {
    console.log(req.body)
    request.push(req.body)
})

app.get("/", (req, res) => { 
    res.json(request)
})

app.listen(5000)