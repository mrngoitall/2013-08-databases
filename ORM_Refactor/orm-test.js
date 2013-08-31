var url = require('url');
var fs = require('fs');
var mysql = require('mysql');
var Sequelize = require('sequelize');
var sequelize = new Sequelize("orm_chat", "root", "fzPJlqy2fLs7srDER6LRx9eo8");

// var Message = sequelize.define('Message', { 
//   user: Sequelize.STRING, 
//   room: Sequelize.STRING,
//   message: Sequelize.STRING });

var User = sequelize.define('User', { name: Sequelize.STRING });
var Room = sequelize.define('Room', { name: Sequelize.STRING });
var Message = sequelize.define('Message', { message: Sequelize.STRING });

Message.hasOne(User);
Message.hasOne(Room);

User.hasMany(Message);
Room.hasMany(Message);

Message.belongsTo(User);
Message.belongsTo(Room);

sequelize.sync({force:true}).success(function() {
  var user = User.create({
    name: 'Will'
  }).success(function() {
    console.log("Saved user.");
  });;

  var room = Room.create({
    name: 'messages'
  }).success(function() {
    console.log("Saved room.");
  });

  var message = Message.create({
    message: 'Test message'
  });

  message.setUser(user).success(function() {
    console.log("Associated user with message.");
  });
  message.setRoom(room).success(function() {
    console.log("Associated room with message.");
  });

  message.save().success(function() {
    console.log('Done saving!');
  });
});

