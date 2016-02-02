module.exports = (game) ->

  game.speech =
    show: (message) ->
      style = message.style or "bubble"
      horizontal = message.alignment?.horizontal or "right"
      vertical = message.alignment?.vertical or "above"
      duration = message.duration or 1500

      element = document.createElement "div"
      element.className = "speechContainer"

      contained = document.createElement "div"
      contained.className = "speech"

      capsify = (x) -> (x.charAt 0).toUpperCase() + (x.slice 1)

      contained.style.borderImageSource = "url('" + (require ("./speech" + (capsify style) + (capsify horizontal) + (capsify vertical) + ".png")) + "')"
      contained.textContent = message.text
      contained.innerText = message.text

      switch horizontal
        when "left" then contained.style.right = "0"
        when "right" then contained.style.left = "0"

      switch vertical
        when "above" then contained.style.bottom = "0"
        when "below" then contained.style.top = "0"

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