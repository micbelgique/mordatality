class @Simulation
  constructor: (width, height) ->
    @width  = width
    @height = height
    @people = []

    @initializeRenderer()
    @refreshStage()
    @animate()

  initializeRenderer: ->
    @renderer = new PIXI.autoDetectRenderer(@width, @height, {
      antialias:       true,
      backgroundColor: 0x333344
    })

    $('#simulation')[0].appendChild(@renderer.view)

  refreshStage: ->
    @stage = new PIXI.Container()
    @initializeBackground()
    #@bindScroll()

    @initializePeople()

  initializeBackground: ->
    @background        = PIXI.Sprite.fromImage('assets/pixel.gif');
    @background.width  = @width
    @background.height = @height

    @stage.simulation = @
    @stage.background = @background
    @stage.addChild(@background)

  initializePeople: ->
    for i in [0..99]
      @people.push(new Person(@stage, 0, i))

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
      person.updateAge()
      person.updatePosition()

    @renderer.render(@stage)
