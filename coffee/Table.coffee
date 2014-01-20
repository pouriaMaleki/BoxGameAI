module.exports = class Table

	constructor: ->

		@h = new Uint8Array 20
		@v = new Uint8Array 20

	getHover1: ->

	getHover2: ->

	getHover3: ->

	getHover4: ->

	getHover5: ->

	getHover6: ->

	getHorizontal: (x, y) ->

		x * 4 + y

	getVertical: (x, y) ->

		x * 5 + y

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

		if @checkDirection(x1, y1, x2, y2) is 1

			if y1 < y2

				return {

					index: @getHorizontal(x1, y1)
					direction: 1

				}

			else

				return {

					index: @getHorizontal(x2, y2)
					direction: 1

				}

		else

			if x1 < x2

				return {

					index: @getVertical(x1, y1)
					direction: 0

				}

			else

				return {

					index: @getVertical(x2, y2)
					direction: 0

				}

	convertLineToCordinate: (index) ->

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

