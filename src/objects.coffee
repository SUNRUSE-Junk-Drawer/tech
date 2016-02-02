module.exports = (game) ->
  objectStates = {}
  objectElements = {}

  game.objects =
    getState: (name) -> objectStates[name]
    setState: (name, to) ->
      objectStates[name] = to
      el = objectElements[name]
      object = game.map.objects[name]
      state = object.states[to]
      if state is null
        el.style.visibility = "none"
      else
        el.style.visibility = "block"
        el.style.left = state.destination.left + "vh"
        el.style.top = state.destination.top + "vh"
        el.style.width = 1 + state.source.right - state.source.left + "vh"
        el.style.height = 1 + state.source.bottom - state.source.top + "vh"
        el.style.backgroundPosition = "-" + state.source.left + "vh -" + state.source.top + "vh"
        title = state.tooltip?[game.localization] or object.tooltip?[game.localization] or null
        if title isnt null then el.title = title
      return
    say: (name, message) ->
      object = game.map.objects[name]
      state = object.states[game.objects.getState name]
      message.position =
        x: if message.alignment?.horizontal is "left" then state.destination.left else state.destination.left + state.source.right - state.source.left
        y: if message.alignment?.vertical is "below" then state.destination.top + state.source.bottom - state.source.top else state.destination.top
      game.speech.show message

  for key, value of game.map.objects
    do (key, value) ->
      el = document.createElement "div"
      el.className = "object"
      el.style.backgroundImage = "url('" + game.map.sheet.url + "')"
      el.style.backgroundSize = (Math.max game.map.sheet.width, game.map.sheet.height) + "vh"
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