const express = require("express")
const cors = require("cors")
const bodyParser = require("body-parser")
const app = express()

let request = []

app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())
app.use(cors({
    "origin": "*",
    "methods": "GET,HEAD,PUT,PATCH,POST,DELETE",
    "preflightContinue": false,
    "optionsSuccessStatus": 204
  }))

app.post("/", (req, res, next) => {
    console.log(req.body)
    request.push(req.body)
    res.send("All good!")
})

app.get("/", (req, res) => {
    res.json(request)
})

app.listen(5000)