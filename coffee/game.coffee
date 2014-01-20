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

# t.getHoverLines(2,2,2,3)
# t.getHoverLines(2,1,3,1)
t.getHoverLines(0,0,1,0)
