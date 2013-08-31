var requestHandler = require('./request-handler');
var express = require("express");
var app = express();

var port = 8081;
app.use(express.static(__dirname));
app.use(requestHandler.handleRequest);
console.log("Listening on port: " + port);
app.listen(port);
