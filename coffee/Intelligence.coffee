Table = require './Table'

module.exports = class Intelligence

	constructor: ->

		@table = new Table

	getNextMove: ->

		@generateRandomMove()

	setLastMove: (@lastMove) ->

		@table.setLine(@lastMove.x1, @lastMove.y1, @lastMove.x2, @lastMove.y2)

	myMove: (move) ->

		@table.setLine(move.x1, move.y1, move.x2, move.y2)

	generateRandomMove: ->

		row = Math.floor(Math.random() * 5)
		col = Math.floor(Math.random() * 5)

		rand = Math.floor(Math.random() * 2)

		if rand < 1

			move =

				x1: row
				y1: col

				x2: row + 1
				y2: col

		else

			move =

				x1: row
				y1: col

				x2: row
				y2: col + 1
