var url = require('url');
var fs = require('fs');
var mysql = require('mysql');
var Sequelize = require('sequelize');
var sequelize = new Sequelize("orm_chat", "root", "fzPJlqy2fLs7srDER6LRx9eo8");

var Message = sequelize.define('Message', { 
  user: Sequelize.STRING, 
  room: Sequelize.STRING,
  message: Sequelize.STRING });

//sequelize.sync({force:true});
sequelize.sync();

var message = Message.build({
  user: 'Will',
  room: 'messages',
  message: "Damn sequelize. Why can't you be more flexible? :("
});

message.save().success(function() {
  console.log('done!');
});