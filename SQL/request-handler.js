var url = require('url');
var fs = require('fs');
var mysql = require('mysql');
var dbConnection = mysql.createConnection({
  user: "root",
  password: "fzPJlqy2fLs7srDER6LRx9eo8",
  database: "chat"
});
dbConnection.connect();

/* You should implement your request handler function in this file.
 * But you need to pass the function to http.createServer() in
 * basic-server.js.  So you must figure out how to export the function
 * from this file and include it in basic-server.js. Check out the
 * node module documentation at http://nodejs.org/api/modules.html. */

var defaultCorsHeaders = {
  "access-control-allow-origin": "*",
  "access-control-allow-methods": "GET, POST, PUT, DELETE, OPTIONS",
  "access-control-allow-headers": "content-type, accept",
  "access-control-max-age": 10 // Seconds.
};

var headers = defaultCorsHeaders;
headers['Content-Type'] = "text/plain";
var statusCode;

exports.handleRequest = function(request, response) {
  console.log("Serving request type " + request.method + " for url " + request.url);
  var parsedURL = url.parse(request.url).pathname.split("/");
  console.log("Parsed URL: ", parsedURL);

  if (request.url === '/js/setup.js') {
    fs.readFile(__dirname + '/js/setup.js',
      function (err, data) {
        if (err) {
          response.writeHead(500);
          return response.end('Error loading setup.js');
        }

        response.writeHead(200,{ 'Content-Type': 'text/javascript' });
        response.end(data);
      });
  } else if (request.url === '/css/styles.css') {
    fs.readFile(__dirname + '/css/styles.css',
      function (err, data) {
        if (err) {
          response.writeHead(500);
          return response.end('Error loading styles.css');
        }

        response.writeHead(200,{ 'Content-Type': 'text/css' });
        response.end(data);
      });
  } else if (request.url === '/css/reset.css') {
    fs.readFile(__dirname + '/css/reset.css',
      function (err, data) {
        if (err) {
          response.writeHead(500);
          return response.end('Error loading reset.css');
        }

        response.writeHead(200,{ 'Content-Type': 'text/css' });
        response.end(data);
      });
  } else if (request.url === '/index.html' || request.url === '/') {
    fs.readFile(__dirname + '/index.html',
      function (err, data) {
        if (err) {
          response.writeHead(500);
          return response.end('Error loading index.html');
        }

        response.writeHead(200,{ 'Content-Type': 'text/html' });
        response.end(data);
      });
  } else if (request.method === 'POST') {
    sendMessageHandler(request, response, parsedURL[2]);
  } else if (request.method === 'GET' && parsedURL[1] === 'classes') {
    getMessagesHandler(request, response, parsedURL[2]);
  } else if (request.method === 'GET' && parsedURL[1] === 'listrooms') {
    getChatRoomsHandler(response);
  } else {
    notFoundHandler(request, response);
  }
};

var getMessagesHandler = function(request, response, roomName) {
  statusCode = 200;
  getMessagesQuery = "select * from chatmessages " +
    "where room = ? " +
    "order by created_date desc " +
    "limit 100;";
  dbConnection.query(getMessagesQuery,
    [roomName],
    function(err, results) {
      var messages = [];
      for (var i = 0; i < results.length; i++) {
        messages.push(results[i]);
      }
      response.writeHead(statusCode, headers);
      response.end(JSON.stringify(messages));
    });
};

var getChatRoomsHandler = function(response) {
  statusCode = 200;
  getRoomsQuery = "select distinct room from chatmessages " +
    "order by room asc " +
    "limit 100;";
  dbConnection.query(getRoomsQuery, 
    function(err, results) {
      var rooms = [];
      for (var i = 0; i < results.length; i++) {
        rooms.push(results[i].room);
      }
      response.writeHead(statusCode, headers);
      response.end(JSON.stringify(rooms));
    });
  
};

var sendMessageHandler = function(request, response, roomName) {
  var messageData = '';
  request.on('data', function(chunk) {
    messageData += chunk;
  });
  request.on('end', function() {
    statusCode = 201;
    var insertMessageQuery = "insert into chatmessages "+
      "(username, room, message, created_date) "+
      "values (?, ?, ?, now());";
    var parsedMessage = JSON.parse(messageData);
    dbConnection.query(insertMessageQuery, 
      [parsedMessage.username, roomName, parsedMessage.message], 
      function(err, results) {
        response.writeHead(statusCode, headers);
        response.end();
    });
  });
};

var notFoundHandler = function(request, response) {
  statusCode = 404;
  response.writeHead(statusCode, headers);
  response.end("404 not found!");
};

