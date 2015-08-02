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

    full = true
    for person in people
      if !person
        full = false
        break

    if full
      people.push(new Person(@stage, 0, sex, people.length))
    else
      inserted = false
      while !inserted
        i = Math.floor(Math.random() * (people.length - 1))
        if !people[i]
          people[i] = new Person(@stage, 0, sex, i)
          inserted  = true

  updatePosition: ->
    @circle.x = @age * @simulation.width / 104.0
    @circle.y = 46 + @verticalPosition * @simulation.height / 220
