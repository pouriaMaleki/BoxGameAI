net = require 'net'
Intelligence = require './Intelligence'
ManageMessages = require './ManageMessages'

ai = new Intelligence
mm = new ManageMessages

client = net.connect {port: 8000}, ->

	console.log "client connected"


client.on "data", (data) ->

	data = data.toString()

	console.log 'recived message:' + data

	mm.processMessage data

	console.log 'yt: ' + mm.yt

	console.log 'move: ' + JSON.stringify(mm.move)

	# x = ai.getNextMove()

	# console.log 'my message is: ' + x

	# client.write x

	# client.end()

client.on "end", ->

	console.log "client disconnected"
