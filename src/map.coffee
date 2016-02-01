module.exports =
    width: 384
    height: 100
    background: require "./background.png"
    sheet:
        url: require "./sprites.png"
        width: 64
        height: 64
    spawns:
        default: 20
    objects:
        dresser:
            activated: (game) -> switch game.objects.getState "dresser"
                when "opened" then game.objects.setState "dresser", "closed"
                when "closed" then game.objects.setState "dresser", "opened"
            states:
                opened:
                    source:
                        left: 18
                        right: 34
                        top: 10
                        bottom: 24
                    destination:
                        left: 20
                        top: 5
                closed:
                    source:
                        left: 24
                        right: 43
                        top: 31
                        bottom: 45
                    destination:
                        left: 17
                        top: 5
                default: "opened"
        dresser2:
            activated: (game) -> switch game.objects.getState "dresser2"
                when "opened" then game.objects.setState "dresser2", "closed"
                when "closed" then game.objects.setState "dresser2", "opened"
            states:
                opened:
                    source:
                        left: 18
                        right: 34
                        top: 10
                        bottom: 24
                    destination:
                        left: 50
                        top: 5
                closed:
                    source:
                        left: 24
                        right: 43
                        top: 31
                        bottom: 45
                    destination:
                        left: 47
                        top: 5
                default: "opened"
        dresser3:
            activated: (game) -> switch game.objects.getState "dresser3"
                when "opened" then game.objects.setState "dresser3", "closed"
                when "closed" then game.objects.setState "dresser3", "opened"
            states:
                opened:
                    source:
                        left: 18
                        right: 34
                        top: 10
                        bottom: 24
                    destination:
                        left: 80
                        top: 5
                closed:
                    source:
                        left: 24
                        right: 43
                        top: 31
                        bottom: 45
                    destination:
                        left: 77
                        top: 5
                default: "opened"