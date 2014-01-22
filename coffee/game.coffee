net = require 'net'

ManageMessages = require './ManageMessages'

mm = new ManageMessages

client = net.connect {port: 8000}, ->

	console.log "client connected"

client.on "data", (data) ->

	data = data.toString()

	console.log "Server Message: " + data

	mm.processMessage data, ->

		message = mm.getMessage()

		if message

			console.log "My Message: " + message

			client.write message

	, ->

		client.end()

client.on "end", ->

	console.log "client disconnected"