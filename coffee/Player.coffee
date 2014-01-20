Intelligence = require './Intelligence'

module.exports = class Player

	constructor: ->

		@yt = 0

		@intel = new Intelligence

	getNextMove: ->

		@myLastMove = @intel.getNextMove()

	setMove: (move) ->

		@intel.setLastMove move

	myMoveIsDone: ->

		@intel.myMove(@myLastMove)

	myFailMoveCorrected: (move) ->

		@myLastMove = move
		@intel.myMove(move)

	isMyTurn: ->

		if @yt > 0

			return true

		return false
