class @Person
  constructor: (stage, age, verticalPosition) ->
    @stage            = stage
    @age              = age
    @verticalPosition = verticalPosition

    @circle = new PIXI.Graphics()
    @circle.lineStyle(0, 0xDDDDEE, 1)
    @circle.beginFill(0xEEEEFF)
    @circle.drawCircle(0, 0, @stage.simulation.height / 150.0 / 1.5)
    @stage.addChild(@circle)

  destroy: ->
    @stage.removeChild(@circle)
    @stage.simulation.people[@verticalPosition] = undefined

  updateAge: ->
    @age += 0.1

    if Math.random() < 0.01
      @destroy()

  updatePosition: ->
    @circle.x = 20 + @age * @stage.simulation.width / 104.0
    @circle.y = 20 + @verticalPosition * @stage.simulation.height / 150.0
