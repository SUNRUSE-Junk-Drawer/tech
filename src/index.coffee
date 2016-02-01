require "./index.sass"

game = require "./game.coffee"
map = require "./map.coffee"

addEventListener "load", ->
  document.body.appendChild game map
  return