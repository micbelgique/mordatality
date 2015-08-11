$ ->
  if $('html#simulations-show').length
    simulation = new Simulation(
      window.innerWidth,
      window.innerHeight
    )

    $('button').css('left', $(window).width() / 2 - $('button').width() / 2)
    $('button').show()

    $('#myModal').modal()
