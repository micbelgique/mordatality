$ ->
  if $('html#simulations-show').length
    $.urlParam = (name) ->
      results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href)
      if results==null
        return null
      else
        return results[1] || 0

    simulation = new Simulation(
      window.innerWidth,
      window.innerHeight
      $.urlParam('type')
    )

    $('button').css('left', $(window).width() / 2 - $('button').width() / 2)
    $('button').show()

    if $.urlParam('modal') != '0'
      $('#myModal').modal()
