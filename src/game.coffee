objects = require "./objects.coffee"
player = require "./player.coffee"
speech = require "./speech.coffee"

module.exports = (map) ->
  element = document.createElement "div"
  element.className = "game"
  element.style.width = map.width + "vmin"
  element.style.height = map.height + "vmin"
  element.style.marginTop = (map.height / -2) + "vmin"
  element.style.backgroundImage = "url('" + map.background + "')"
  element.style.backgroundSize = (Math.max map.width, map.height) + "vmin"
  
  output =
    localization: "english"
    map: map
    element: element

  objects output
  player output
  speech output

  element