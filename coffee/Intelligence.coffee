Table = require './Table'

module.exports = class Intelligence

	constructor: (@row, @col) ->

		@table = new Table @row, @col

	getNextMove: ->

		return @generateNextBestMove(@table, [@lastMove.x1, @lastMove.y1, @lastMove.x2, @lastMove.y2])

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

	generateNextBestMove: (table, move) ->

		max = -10000

		cordinates = [null, null, null, null]

		for tableLines, i in table.h

			if tableLines is 0

				cords = table.convertLineToCordinate(i, 1)

				lines = table.getHoverLines(cords[0], cords[1], cords[2], cords[3])

				value = @calcValue lines

				childsVal = @level2(table.h, table.v, cords)

				realVal = value - childsVal

				if max < realVal

					max = realVal

					cordinates = cords

		for tableLines, i in table.v

			if tableLines is 0

				cords = table.convertLineToCordinate(i, 0)

				lines = table.getHoverLines(cords[0], cords[1], cords[2], cords[3])

				value = @calcValue lines

				childsVal = @level2(table.h, table.v, cords)

				realVal = value - childsVal

				if max < realVal

					max = realVal

					cordinates = cords

		return {

			val: max

			x1: cordinates[0]
			y1: cordinates[1]

			x2: cordinates[2]
			y2: cordinates[3]

		}

	level2: (h, v, move) ->

		table = new Table @row, @col

		table.h = h
		table.v = v

		table.setLine(move[0], move[1], move[2], move[3])

		max = -10000

		for tableLines, i in table.h

			if tableLines is 0

				cords = table.convertLineToCordinate(i, 1)

				lines = table.getHoverLines(cords[0], cords[1], cords[2], cords[3])

				value = @calcValue lines

				if max < value

					max = value

		for tableLines, i in table.v

			if tableLines is 0

				cords = table.convertLineToCordinate(i, 0)

				lines =  table.getHoverLines(cords[0], cords[1], cords[2], cords[3])

				value = @calcValue lines

				if max < value

					max = value

		table.setLine0(move[0], move[1], move[2], move[3])

		return max

	calcValue: (lines) ->

		str = ''

		for line, i in lines

			continue if line is -1

			str = str + line.line.toString()

		if str is '111111'

			return 3

		if str is '111110' or str is '111101' or str is '111011' or str is '110111' or str is '101111' or str is '011111'

			return 2

		part1 = str.substring(0, 3)

		part2 = str.substring(3, 6)

		if part1 is '111' or part2 is '111'

			return 1

		val = 0

		if part1 is '011' or part1 is '101' or part1 is '110'

			val--

		if part2 is '011'  or part2 is '101'  or part2 is '110'

			val--

		if part1 is '001' or part1 is '010' or part1 is '100'

			val += .1

		if part2 is '001' or part2 is '010'  or part2 is '100'

			val += .1

		return val