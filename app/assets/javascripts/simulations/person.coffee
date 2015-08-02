class @Person
  constructor: (stage, age, sex, verticalPosition) ->
    @stage            = stage
    @age              = age
    @sex              = sex
    @dead             = false
    @verticalPosition = verticalPosition
    @simulation       = stage.simulation
    @delay            = @simulation.delay
    @probabilities    = @simulation.probabilities

    color = if sex == 'M' then 0xB4D8E7 else 0xFFC0CB

    @circle = new PIXI.Graphics()
    @circle.beginFill(color)
    @circle.drawCircle(0, 0, @simulation.height / 150.0)
    @circle.x = -100
    @stage.addChild(@circle)

  remove: ->
    if !@dead
      @stage.removeChild(@circle)
      @simulation.people[@verticalPosition] = undefined
      @dead = true

  update: ->
    previousAge  = @age
    @age        += @delay

    @updateDeath(previousAge, @age)
    @updateBirth(previousAge, @age)
    @updateMigration(previousAge, @age)

    if !@dead
      @updatePosition()

  updateDeath: (previousAge, age) ->
    if Math.floor(previousAge) != Math.floor(age)
      name = if @sex == 'M' then 'male_death' else 'female_death'

      if Math.random() < @probabilities[name][Math.floor(age)]
        @remove()

  updateBirth: (previousAge, age) ->
    if @sex == 'F' && Math.floor(previousAge) != Math.floor(age)
      if Math.random() < @probabilities['birth'][Math.floor(age)]
        @addChild()

  updateMigration: (previousAge, age) ->
    if Math.floor(previousAge) != Math.floor(age)
      name = if @sex == 'M' then 'male_migration' else 'female_migration'

      if Math.random() < @probabilities[name]['in']
        @addPerson()

      if Math.random() < @probabilities[name]['out']
        @remove()

  addChild: ->
    people = @simulation.people
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
        i = Math.floor(Math.random() * (people.length))
        if !people[i]
          people[i] = new Person(@stage, 0, sex, i)
          inserted  = true

  addPerson: ->
    people = @simulation.people
    sex    = if Math.random() < 0.5 then 'M' else 'F'
    age    = Math.floor(Math.random() * 39) # max age of immigrant

    full = true

    for person in people
      if !person
        full = false
        break

    if full
      people.push(new Person(@stage, age, sex, people.length))
    else
      inserted = false
      while !inserted
        i = Math.floor(Math.random() * (people.length))
        if !people[i]
          people[i] = new Person(@stage, age, sex, i)
          inserted  = true

  updatePosition: ->
    if @circle
      @circle.x = @age * @simulation.width / 104.0
      @circle.y = 46 + @verticalPosition * @simulation.height / 3000
