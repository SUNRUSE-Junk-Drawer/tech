objects = require "./objects.coffee"
player = require "./player.coffee"
speech = require "./speech.coffee"

module.exports = (map) ->
  element = document.createElement "div"
  element.className = "game"
  element.style.width = map.width + "vh"
  element.style.height = map.height + "vh"
  element.style.marginTop = ((100 - map.height) / 2) + "vh"
  element.style.backgroundImage = "url('" + map.background + "')"
  element.style.backgroundSize = (Math.max map.width, map.height) + "vh"

  output =
    localization: "english"
    map: map
    element: element

  objects output
  player output
  speech output

  element