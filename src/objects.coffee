module.exports = (game) ->
  objectStates = {}
  objectElements = {}

  game.objects =
    getState: (name) -> objectStates[name]
    setState: (name, to) ->
      objectStates[name] = to
      el = objectElements[name]
      state = game.map.objects[name].states[to]
      if state is null
        el.style.visibility = "none"
      else
        el.style.visibility = "block"
        el.style.left = state.destination.left + "vmin"
        el.style.top = state.destination.top + "vmin"
        el.style.width = 1 + state.source.right - state.source.left + "vmin"
        el.style.height = 1 + state.source.bottom - state.source.top + "vmin"
        el.style.backgroundPosition = "-" + state.source.left + "vmin -" + state.source.top + "vmin"
      return

  for key, value of game.map.objects
    do (key, value) ->
      el = document.createElement "div"
      el.className = "object"
      el.style.backgroundImage = "url('" + game.map.sheet.url + "')"
      el.style.backgroundSize = (Math.max game.map.sheet.width, game.map.sheet.height) + "vmin"
      objectElements[key] = el
      game.objects.setState key, value.states.default
      game.element.appendChild el
      el.onclick = ->
        state = value.states[game.objects.getState key]
        location = game.player.getLocation()
        if location < state.destination.left
          game.player.walkTo state.destination.left, -> value.activated game
        else if location > state.destination.left + state.source.right - state.source.left
          game.player.walkTo state.destination.left + state.source.right - state.source.left, -> value.activated game
        else value.activated game
        return
      return
  return