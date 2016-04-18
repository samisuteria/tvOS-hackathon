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

//Express

app.get('/', function(req, res) {
	res.send("CGRekt Server");
})

io.on('connection', function(socket) {
	console.log('a device connected');
	
	socket.on('refreshList', function(x) {
		socket.emit('roomlist', rooms);
		console.log('emitted roomlist');
	})

	socket.on('joinRoom', function(room) {
		console.log("Socket wanted to join room: " + room)
		socket.join(room)
	})

	socket.on('addSong', function(song, currentRoom) {
		console.log("Socket added song: " + song)
		console.log("emitting to " + currentRoom)
		io.to(currentRoom).emit('addToQueue', song)
	})

	socket.on('createRoom', function(x) {
		console.log("tv asking to create room")
		var randomroom = randomRoomName()
		rooms.unshift(randomroom)
		socket.join(randomroom)
		socket.emit('createdRoom', randomroom)
	})

})

http.listen((process.env.PORT || 3000), function() {
	console.log('listening on ' + app.get('port'));
})



















