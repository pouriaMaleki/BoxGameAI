Player = require './Player'

module.exports = class ManageMessages

	constructor: ->

		@player = new Player

		@moveRegex = ///^(\[([0-9]),([0-9]|1[0-4]),([0-9]),([0-9]|1[0-4])])$///

		@bonusRegex = ///Bonus\(\+([1-2]),[A-B]\)(\|\[([0-9]),([0-9]|1[0-4]),([0-9]),([0-9]|1[0-4])])?///

		@invalidRegex = ///(Time`sUP\(\)|InValid\(\))\|(\[([0-9]),([0-9]|1[0-4]),([0-9]),([0-9]|1[0-4])])///

	processMessage: (message) ->

		firstMatch = message.substring(0, 1)

		switch firstMatch

			when 'S'

				@player.yt++

				return

			when 'R'

				@player.yt--

				return

		matchMove = message.match(@moveRegex)

		if matchMove

			@player.yt++

			@player.setMove

				x1: matchMove[2]
				y1: matchMove[3]

				x2: matchMove[4]
				y2: matchMove[5]

			return

		invalidMatch = message.match(@invalidRegex)

		if invalidMatch

			@player.yt--

			@player.myFailMoveCorrected

				message: invalidMatch[1]

				x1: invalidMatch[3]
				y1: invalidMatch[4]

				x2: invalidMatch[5]
				y2: invalidMatch[6]

		matchBonus = message.match(@bonusRegex)

		if matchBonus

			count = parseInt(matchBonus[1])

			if matchBonus[3] is undefined or matchBonus[3] is null

				@player.yt = count

			else

				@player.yt = -count + 1

				@player.setMove

					x1: matchBonus[3]
					y1: matchBonus[4]

					x2: matchBonus[5]
					y2: matchBonus[6]

	getMessage: ->

		if @player.isMyTurn()

			move = @player.getNextMove()

			if move

				'[' + move.x1 + ',' + move.y1 + ',' + move.x2 + ',' + move.y2 + ']'
