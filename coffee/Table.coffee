module.exports = class Table

	constructor: (@row, @col) ->

		@h = new Uint8Array (@col - 1) * @row
		@v = new Uint8Array @col * (@row - 1)

	getHoverLines: (x1, y1, x2, y2) ->

		result = @normalizeCordinates(x1, y1, x2, y2)

		x1 = result[0]
		y1 = result[1]
		x2 = result[2]
		y2 = result[3]

		if @checkDirection(x1, y1, x2, y2) is 1

			l1 = @getLine(x2 - 1, y2 - 1, x1, y1)
			l2 = @getLine(x1 - 1, y1, x2 - 1, y2)
			l3 = @getLine(x1 - 1, y1 + 1, x2, y2)
			l4 = @getLine(x2, y2, x1 + 1, y1 + 1)
			l5 = @getLine(x1 + 1, y1, x2 + 1, y2)
			l6 = @getLine(x1, y1, x2 + 1, y2 - 1)

			return [l1, l2, l3, l4, l5, l6]

		else

			l1 = @getLine(x1, y1, x2 - 1, y2 + 1)
			l2 = @getLine(x1, y1 + 1, x2, y2 + 1)
			l3 = @getLine(x2, y2, x1 + 1, y1 + 1)
			l4 = @getLine(x1 + 1, y1 - 1, x2, y2)
			l5 = @getLine(x1, y1 - 1, x2, y2 - 1)
			l6 = @getLine(x2 - 1, y2 - 1, x1, y1)

			return [l1, l2, l3, l4, l5, l6]

	getHorizontal: (x, y) ->

		x * (@col - 1) + y

	getVertical: (x, y) ->

		x * @col + y

	horizontal: (x, y, value = null) ->

		if value is null

			return @h[@getHorizontal(x, y)]

		else

			index = @getHorizontal(x, y)

			@h[index] = value

			return index

	vertical: (x, y, value = null) ->

		if value is null

			return @h[@getVertical(x, y)]

		else

			index = @getVertical(x, y)

			@h[index] = value

			return index

	convertCordinateToLine: (x1, y1, x2, y2) ->

		result = @normalizeCordinates(x1, y1, x2, y2)

		x1 = result[0]
		y1 = result[1]
		x2 = result[2]
		y2 = result[3]

		if @checkDirection(x1, y1, x2, y2) is 1

			return {

				index: @getHorizontal(x1, y1)
				direction: 1

			}

		else

			return {

				index: @getVertical(x1, y1)
				direction: 0

			}

	convertLineToCordinate: (index, direction) ->

		if direction is 1

			x = Math.floor(index / (@col - 1))
			y = index % (@col - 1)

			return [x, y, x, y + 1]

		else

			x = Math.floor(index / @col)
			y = index % @col

			return [x, y, x + 1, y]

	checkDirection: (x1, y1, x2, y2) ->

		if x1 - x2 is 0 and Math.abs(y1 - y2) is 1
			# h
			return 1

		else if Math.abs(x1 - x2) is 1 and y1 - y2 is 0
			# v
			return 0

		# bad
		return false

	setLine: (x1, y1, x2, y2) ->

		result = @convertCordinateToLine(x1, y1, x2, y2)

		if result.direction is 1

			@h[result.index] = 1

		else

			@v[result.index] = 1

	setLine0: (x1, y1, x2, y2) ->

		result = @convertCordinateToLine(x1, y1, x2, y2)

		if result.direction is 1

			@h[result.index] = 0

		else

			@v[result.index] = 0

	getLine: (x1, y1, x2, y2) ->

		if x1 < 0 or y1 < 0 or x2 < 0 or y2 < 0

			return -1

		if (x1 > (@row - 1)) or (y1 > (@col - 1)) or (x2 > (@row - 1)) or (y2 > (@col - 1))

			return -1

		result = @convertCordinateToLine(x1, y1, x2, y2)

		if result.direction is 1

			return {

				line: @h[result.index]
				direction: 1
			}

		else

			return {

				line: @v[result.index]
				direction: 0
			}

	normalizeCordinates: (x1, y1, x2, y2) ->

		if y1 > y2 or x1 > x2

			return [x2, y2, x1, y1]

		return [x1, y1, x2, y2]