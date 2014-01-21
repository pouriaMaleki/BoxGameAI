net = require 'net'

ManageMessages = require './ManageMessages'

mm = new ManageMessages
# mm.processMessage('Start()')
# console.log mm.getMessage()


client = net.connect {port: 8000}, ->

	console.log "client connected"

client.on "data", (data) ->

	data = data.toString()

	console.log data

	mm.processMessage data

	message = mm.getMessage()

	if message

		client.write message

client.on "end", ->

	console.log "client disconnected"
