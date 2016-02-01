module.exports = (game, spawnName) ->
  element = document.createElement "player"
  element.className = "player"

  pixelsPerSecond = 32
  walkingFrom = walkingTo = element.style.left = game.map.spawns[spawnName or "default"]
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
      element.style.left = x + "vmin"
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
          element.style.left = location + "vmin"
      return
    getLocation: ->
      distanceTravelled = ((Date.now() - startedWalking) * pixelsPerSecond / 1000) / (Math.abs walkingFrom - walkingTo)
      if distanceTravelled < 1
        walkingFrom + ((walkingTo - walkingFrom) * distanceTravelled)
      else
        walkingTo