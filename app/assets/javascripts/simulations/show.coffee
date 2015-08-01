$ ->
  if $('html#simulations-show').length
    simulation = new Simulation(
      window.innerWidth,
      window.innerHeight
    )
