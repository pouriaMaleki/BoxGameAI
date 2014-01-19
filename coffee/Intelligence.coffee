module.exports = class Intelligence

	constructor: ->

	getNextMove: ->

		@generateRandomMove()

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