module.exports = class ManageMessages

	constructor: ->

		@yt = 0

	processMessage: (message) ->

		@move = {}

		firstMatch = message.substring(0, 1)

		moveRegex = ///^(\[([0-9]),([0-9]|1[0-4]),([0-9]),([0-9]|1[0-4])])$///

		bonusRegex = ///Bonus\(\+([1-2]),[A-B]\)(\|\[([0-9]),([0-9]|1[0-4]),([0-9]),([0-9]|1[0-4])])?///

		invalidRegex = ///(Time`sUP\(\)|Invalid\(\))\|(\[([0-9]),([0-9]|1[0-4]),([0-9]),([0-9]|1[0-4])])///

		switch firstMatch

			when 'S'

				@yt++

				return

			when 'R'

				@yt--

				return

		matchMove = message.match(moveRegex)

		if matchMove

			@yt++

			@move =

				x1: matchMove[2]
				y1: matchMove[3]

				x2: matchMove[4]
				y2: matchMove[5]

			return

		invalidMatch = message.match(invalidRegex)

		if invalidMatch

			@yt--

			@move =

				message: invalidMatch[1]

				x1: invalidMatch[3]
				y1: invalidMatch[4]

				x2: invalidMatch[5]
				y2: invalidMatch[6]


		matchBonus = message.match(bonusRegex)

		if matchBonus

			count = parseInt(matchBonus[1])

			if matchBonus[3] is undefined or matchBonus[3] is null

				@yt = count

			else

				@yt = -count + 1

				@move =

					x1: matchBonus[3]
					y1: matchBonus[4]

					x2: matchBonus[5]
					y2: matchBonus[6]
