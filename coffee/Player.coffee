Intelligence = require './Intelligence'

module.exports = class Player

	constructor: ->

		@yt = 0

		@intel = new Intelligence

	getNextMove: ->

		@intel.getNextMove()

	setMove: (move) ->

	myFailMoveCorrected: (move) ->

	isMyTurn: ->

		if @yt > 0

			return true

		return false
