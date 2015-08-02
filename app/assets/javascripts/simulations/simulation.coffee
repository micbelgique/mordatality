class @Simulation
  constructor: (width, height) ->
    @width     = width
    @height    = height
    @people    = []
    @iteration = 0
    @delay     = 0.1

    @initializeRenderer()
    @initializeProbabilities( =>
      @initializeStage()
      @animate()
    )

  initializeRenderer: ->
    @renderer = new PIXI.autoDetectRenderer(@width, @height, {
      antialias:       true,
      backgroundColor: 0x333344
    })

    $('#simulation')[0].appendChild(@renderer.view)

  initializeProbabilities: (callback) ->
    # 2 = hainaut
    $.get('api/simulation/probabilities/2', (data) =>
      @probabilities = data
      callback()
    )

  initializeStage: ->
    @stage = new PIXI.Container()
    @initializeBackground()
    @initializeAgeLines()
    @initializeAgeTexts()
    @initializeDate()
    @initializeCount()
    @initializePeople()

  initializeBackground: ->
    @background        = PIXI.Sprite.fromImage('assets/pixel.gif');
    @background.width  = @width
    @background.height = @height

    @stage.simulation = @
    @stage.background = @background
    @stage.addChild(@background)

  initializeAgeLines: ->
    @ageLines = new PIXI.Graphics()
    @ageLines.beginFill(0xAAAAAA)
    for i in [1..10]
      @ageLines.drawRect(@width / 104 * 10 * i, 0, 2, 3000)
    @stage.addChild(@ageLines)

  initializeAgeTexts: ->
    for i in [1..10]
      ageText = new PIXI.Text("#{i*10} ans", {font : '18px Arial', fill : 0xffffff, align : 'left'})
      ageText.x = @width / 104 * 10 * i - 22
      ageText.y = 6
      @stage.addChild(ageText)

  initializeDate: ->
    @date = new PIXI.Text(2010, {font : '22px Arial', fill : 0xffffff, align : 'center'})
    @date.x = 14
    @date.y = @height - 34
    @stage.addChild(@date)

  initializeCount: ->
    @count = new PIXI.Text(@people.length, {font : '22px Arial', fill : 0xffffff, align : 'right'})
    @count.x = @width  - 220
    @count.y = @height - 34
    @stage.addChild(@count)

  initializePeople: ->
    for i in [0..2000]
      if i%2 == 0
        sex = if Math.random() < 0.4814814815 then 'M' else 'F'
        @people.push(new Person(@stage, @randomAge(sex), sex, i))
      else
        @people.push(undefined)

  randomAge: (sex) ->
    number = Math.random()
    name = if sex == 'M' then 'male_age_repartition' else 'female_age_repartition'

    for i in [0..103]
      number = number - @probabilities[name][i]
      if number < 0
        return i
    return 103

  animate: =>
    requestAnimationFrame(@animate)

    @iteration += 1

    # Update date
    @date.text  = "Année : #{Math.floor(2010 + @iteration * @delay)}"

    # Update counter
    count = 0
    for person in @people
      if person
        count++
    @count.text = "Population : #{(count * 10839905.0 / 1000.0 / 1000000.0).toFixed(2)} M"

    # Update people
    length = @people.length - 1
    for i in [0..length]
      if @people[i]
        @people[i].update()

    @renderer.render(@stage)
