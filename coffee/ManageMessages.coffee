module.exports = class ManageMessages

	constructor: ->

		@yt = 0

	processMessage: (message) ->

		firstMatch = message.substring(0, 1)

		moveRegex = ///\[([0-9]),([0-9]|1[0-4]),([0-9]),([0-9]|1[0-4])]///

		bonusRegex = ///Bonus\(\+([1-2]),[A-B]\)(\[([0-9]),([0-9]|1[0-4]),([0-9]),([0-9]|1[0-4])])?///

		switch firstMatch

			when 'S'

				@yt++

			when 'R'

				@yt--

			when 'I'

				@yt--

				matchMove = message.match(moveRegex)

				@move =

					x1: matchMove[1]
					y1: matchMove[2]

					x2: matchMove[3]
					y2: matchMove[4]


			when 'T'

				@yt--

				matchMove = message.match(moveRegex)

				@move =

					x1: matchMove[1]
					y1: matchMove[2]

					x2: matchMove[3]
					y2: matchMove[4]

			when '['

				@yt++

				matchMove = message.match(moveRegex)

				@move =

					x1: matchMove[1]
					y1: matchMove[2]

					x2: matchMove[3]
					y2: matchMove[4]

			when 'B'

				matchBonus = message.match(bonusRegex)

				if matchBonus

					count = parseInt(matchBonus[1])

					if matchBonus[2] is undefined or matchBonus[2] is null

						@yt -= count

					else

						@yt += count

					@move =

						x1: matchBonus[2]
						y1: matchBonus[3]

						x2: matchBonus[4]
						y2: matchBonus[5]