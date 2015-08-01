class @Person
  constructor: (stage, age, verticalPosition) ->
    @stage            = stage
    @age              = age
    @verticalPosition = verticalPosition

    @circle = new PIXI.Graphics()
    @circle.lineStyle(0, 0xDDDDEE, 1)
    @circle.beginFill(0xEEEEFF)
    @circle.drawCircle(0, 0, 3)
    @stage.addChild(@circle)

  updateAge: ->
    @age += 0.1
    @age = @age % 104

  updatePosition: ->
    @circle.x = 20 + @age * 6
    @circle.y = 20 + @verticalPosition * 6
