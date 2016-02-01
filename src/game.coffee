objects = require "./objects.coffee"
player = require "./player.coffee"

module.exports = (map) ->
  element = document.createElement "div"
  element.className = "game"

  output =
    map: map
    element: element

  objects output
  player output

  element