Player = require './Player'

module.exports = class ManageMessages

	constructor: ->

		@player = new Player

		@moveRegex = ///^(\[([0-9]),([0-9]|1[0-4]),([0-9]),([0-9]|1[0-4])])$///

		@bonusRegex = ///Bonus\(\+([1-2]),[A-B]\)(\|\[([0-9]),([0-9]|1[0-4]),([0-9]),([0-9]|1[0-4])])?///

		@invalidRegex = ///(Time`sUP\(\)|InValid\(\))\|(\[([0-9]),([0-9]|1[0-4]),([0-9]),([0-9]|1[0-4])])///

	processMessage: (message, func, onEnd) ->

		firstMatch = message.substring(0, 1)

		switch firstMatch

			when 'R'

				@player.myMoveIsDone()

				@player.yt--

			when 'S'

				secondMatch = message.substring(1, 2)

				if secondMatch is 't'

					@player.yt++

					do func

					return

				else

					@player.yt = 0

					console.log '_________________LOST__________________'

					do onEnd

					return

			when 'C'

				@player.yt = 0

				console.log '_________________WON__________________'

				do onEnd

				return

			when 'G'

				regex = ///^Game_Info.\(([0-9]|1[0-9]),([0-9]|1[0-9]),([0-9]|1[0-9]):([0-9]|1[0-9]):([0-9]|1[0-9])\)$///

				startMatch = message.match(regex)

				@player.createIntel(parseInt(startMatch[1]), parseInt(startMatch[2]))

		matchMove = message.match(@moveRegex)

		if matchMove

			@player.yt++

			@player.setMove

				x1: parseInt matchMove[2]
				y1: parseInt matchMove[3]

				x2: parseInt matchMove[4]
				y2: parseInt matchMove[5]

			do func

			return

		invalidMatch = message.match(@invalidRegex)

		if invalidMatch

			@player.yt--

			@player.myFailMoveCorrected

				message: invalidMatch[1]

				x1: parseInt invalidMatch[3]
				y1: parseInt invalidMatch[4]

				x2: parseInt invalidMatch[5]
				y2: parseInt invalidMatch[6]

		matchBonus = message.match(@bonusRegex)

		if matchBonus

			count = parseInt(matchBonus[1])

			if matchBonus[3] is undefined or matchBonus[3] is null

				@player.yt = count

			else

				@player.yt = -count + 1

				@player.setMove

					x1: parseInt matchBonus[3]
					y1: parseInt matchBonus[4]

					x2: parseInt matchBonus[5]
					y2: parseInt matchBonus[6]

		do func

	getMessage: ->

		if @player.isMyTurn()

			move = @player.getNextMove()

			if move

				'[' + move.x1 + ',' + move.y1 + ',' + move.x2 + ',' + move.y2 + ']'
