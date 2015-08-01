class @Person
  constructor: (stage, age, sex, verticalPosition) ->
    @stage            = stage
    @age              = age
    @sex              = sex
    @verticalPosition = verticalPosition
    @simulation       = stage.simulation
    @delay            = @simulation.delay
    @probabilities    = @simulation.probabilities

    color = if sex == 'M' then 0xB4D8E7 else 0xFFC0CB

    @circle = new PIXI.Graphics()
    @circle.beginFill(color)
    @circle.drawCircle(0, 0, @simulation.height / 150.0)
    @stage.addChild(@circle)

  destroy: ->
    @stage.removeChild(@circle)
    @simulation.people[@verticalPosition] = undefined

  update: ->
    previousAge  = @age
    @age        += @delay

    @updateDeath(previousAge, @age)
    @updateBirth(previousAge, @age)
    @updatePosition()

  updateDeath: (previousAge, age) ->
    if Math.floor(previousAge) != Math.floor(age)
      name = if @sex == 'M' then 'male_death' else 'female_death'

      if Math.random() < @probabilities[name][Math.floor(age)]
        @destroy()

  updateBirth: (previousAge, age) ->
    if @sex == 'F' && Math.floor(previousAge) != Math.floor(age)
      if Math.random() < @probabilities['birth'][Math.floor(age)]
        @addChild()

  addChild: ->
    people = @simulation.people
    added  = false
    sex    = if Math.random() < 0.5 then 'M' else 'F'

    for person, i in people
      if !person
        people[i] = new Person(@stage, 0, sex, i)
        added     = true
        break

    if !added
      people.push(new Person(@stage, 0, sex, people.length))

  updatePosition: ->
    @circle.x = 20 + @age * @simulation.width / 120.0
    @circle.y = 20 + @verticalPosition * @simulation.height / 220
