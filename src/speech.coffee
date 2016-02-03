module.exports = (game) ->

  game.speech =
    show: (message) ->
      duration = message.duration or 1500

      element = document.createElement "div"
      element.className = "speechContainer"

      contained = document.createElement "div"
      contained.className = "speech"

      contained.setAttribute "horizontal", message.alignment?.horizontal or "right"
      contained.setAttribute "vertical", message.alignment?.vertical or "above"
      contained.setAttribute "style", message.style or "bubble"
      contained.textContent = message.text
      contained.innerText = message.text

      element.appendChild contained

      element.style.left = message.position.x + "vh"
      element.style.top = message.position.y + "vh"

      game.element.appendChild element
      setTimeout (->
          game.element.removeChild element
          if message.callback then message.callback()
          return
        ), duration

      return