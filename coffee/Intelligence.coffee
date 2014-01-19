module.exports = class Intelligence

	constructor: ->

	getNextMove: ->

		do ->

			row = Math.floor(Math.random() * 10)
			col = Math.floor(Math.random() * 15)

			rand = Math.floor(Math.random() * 2)

			if rand < 1

				'[' + row + ',' + col + ',' + (row + 1) + ',' + col + ']'

			else

				'[' + row + ',' + col + ',' + row + ',' + (col + 1) + ']'