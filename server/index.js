var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

var rooms = [];

//Helpers

function randomRoomName() {
	var colors = ["Black", "Blue", "Brown", "Gray", "Green", "Orange", "Pink", "Purple", "Red", "White", "Yellow"];
	var emotions = ["Amused", "Bold", "Calm", "Edgy", "Guilty", "Happy", "Kind", "Magical", "Powerful", "Wise"];
	var animals = ["Monkey", "Tiger", "Panda", "Horse", "Deer", "Pig", "Sheep", "Elephant", "Wolf", "Fox", "Bear", "Owl"];
	var number = Math.floor(1000 + Math.random() * 9000)

	var color = colors[Math.floor(Math.random()*colors.length)]
	var emotion = emotions[Math.floor(Math.random()*emotions.length)]
	var animal = animals[Math.floor(Math.random()*animals.length)]

	var room = color + emotion + animal + number

	if (rooms.indexOf(room) > -1) {
		return randomRoomName()
	} else {
		return room
	}
}

//first 3 are just for demos
rooms.push(randomRoomName())
rooms.push(randomRoomName())
rooms.push(randomRoomName())

console.log(rooms)

//Server

app.get('/', function(req, res) {
	res.send("CGRekt Server");
})

io.on('connection', function(socket) {
	console.log('a device connected');
	socket.emit('roomlist', rooms);
	console.log('emitted roomlist');
})

http.listen(3000, function() {
	console.log('listening on 3000');
})



















