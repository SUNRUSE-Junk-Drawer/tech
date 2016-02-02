module.exports = (game, spawnName) ->
  element = document.createElement "player"
  element.className = "player"

  pixelsPerSecond = 32
  height = 24
  width = 7

  walkingFrom = walkingTo = game.map.spawns[spawnName or "default"]
  element.style.transform = "translateX(" + walkingFrom + "vh)"
  element.style.top = (game.map.floorY - height) + "vh"

  startedWalking = undefined
  walkToTimeout = null

  game.element.appendChild element

  game.player =
    walkTo: (x, callback) ->
      game.player.stopWalking()
      walkingTo = x
      startedWalking = Date.now()
      eta = (Math.abs (x - walkingFrom)) / pixelsPerSecond
      element.style.transitionDuration = eta + "s"
      element.style.transform = "translateX(" + x + "vh)"
      if walkToTimeout then clearTimeout walkToTimeout
      walkToTimeout = setTimeout (->
          if callback then callback()
        ), eta * 1000
      return
    stopWalking: ->
      if walkingFrom isnt walkingTo
        location = game.player.getLocation()
        if location is walkingTo
          walkingFrom = walkingTo
        else
          walkingTo = walkingFrom = location
          element.style.transform = "translateX(" + location + "vh)"
      return
    getLocation: ->
      distanceTravelled = ((Date.now() - startedWalking) * pixelsPerSecond / 1000) / (Math.abs walkingFrom - walkingTo)
      if distanceTravelled < 1
        walkingFrom + ((walkingTo - walkingFrom) * distanceTravelled)
      else
        walkingTo
    say: (message) ->
      message.position =
        x: game.player.getLocation() + width * (if message.alignment?.horizontal is "left" then -0.5 else 0.5)
        y: if message.alignment?.vertical is "below" then game.map.floorY else game.map.floorY - height
      game.speech.show message
      return