# net = require 'net'

# ManageMessages = require './ManageMessages'

# mm = new ManageMessages

# client = net.connect {port: 8000}, ->

# 	console.log "client connected"

# client.on "data", (data) ->

# 	mm.processMessage data.toString()

# 	message = mm.getMessage()

# 	if message

# 		client.write message

# client.on "end", ->

# 	console.log "client disconnected"


Table = require './Table'

t = new Table

console.log t.setLine(0,3,0,4)
console.log t.v