objects = require "./objects.coffee"
player = require "./player.coffee"

module.exports = (map) ->
  element = document.createElement "div"
  element.className = "game"
  element.style.width = map.width + "vmin"
  element.style.height = map.height + "vmin"
  element.style.backgroundImage = "url('" + map.background + "')"
  element.style.backgroundSize = (Math.max map.width, map.height) + "vmin"
  element.style.width = map.background.width + "vmin"
  element.style.height = map.background.height + "vmin"

  output =
    map: map
    element: element

  objects output
  player output

  element