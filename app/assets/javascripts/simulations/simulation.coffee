class @Simulation
  constructor: (width, height) ->
    @width  = width
    @height = height
    @people = []
    @delay  = 0.1

    @initializeRenderer()
    @initializeProbabilities( =>
      @refreshStage()
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

  refreshStage: ->
    @stage = new PIXI.Container()
    @initializeBackground()
    @initializeAgeLines()
    @initializeAgeTexts()
    @initializePeople()
    #@bindScroll()

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
      ageText = new PIXI.Text(i*10, {font : '18px Arial', fill : 0xffffff, align : 'right'})
      ageText.x = @width / 104 * 10 * i - 26
      ageText.y = 6
      @stage.addChild(ageText)

  initializePeople: ->
    for i in [0..200]
      if i%2 == 0
        sex = if Math.random() < 0.4814814815 then 'M' else 'F'
        @people.push(new Person(@stage, 0, sex, i))
      else
        @people.push(undefined)

  # bindScroll: ->
  #   @background.interactive = true

  #   onDown = (mouseData) =>
  #     @isDown       = true
  #     @startX       = @x
  #     @startY       = @y
  #     @startOffsetX = mouseData.data.global.x
  #     @startOffsetY = mouseData.data.global.y

  #   onUp = =>
  #     @isDown = false

  #   onMove = (mouseData) =>
  #     if @isDown
  #       @x = @startX + mouseData.data.global.x - @startOffsetX
  #       @y = @startY + mouseData.data.global.y - @startOffsetY

  #   @background.on('mousedown',       onDown)
  #   @background.on('touchstart',      onDown)
  #   @background.on('mouseup',         onUp)
  #   @background.on('touchend',        onUp)
  #   #@background.on('mouseupoutside',  onUp)
  #   #@background.on('touchendoutside', onUp)
  #   @background.on('mousemove',       onMove)
  #   @background.on('touchmove',       onMove)

  animate: =>
    requestAnimationFrame(@animate)

    for person in @people
      if person
        person.update()

    @renderer.render(@stage)
