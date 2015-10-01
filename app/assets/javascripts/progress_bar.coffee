timer = null

init = ->
  timer = setInterval(tick, 2000)
  return

tick = ->
  min = (new Date).getMinutes()
  min = min - 30 if min > 30
  fractionElapsed = min / 30
  # if fractionElapsed > 1.0
  #   clearTimeout timer
  #   return
  leftPos = $('#progress-bar').offset().left
  width = $('#progress-bar').width()
  offsetArrow = $('#arrow').offset()
  offsetArrow.left = leftPos + width * fractionElapsed
  $('#arrow').offset offsetArrow
  # console.log fractionElapsed + ' ' + offsetArrow.left
  return

$(document).ready ->
  init()