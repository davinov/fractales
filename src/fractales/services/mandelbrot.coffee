###*
  @ngdoc service
  @name MandelbrotLevel
  @module %module%.fractales
  @description

  Returns Mandelbrot level given coordinates
###

angular.module '%module%.fractales'
.factory 'Mandelbrot', ->
  level = (x, y, threshold) ->
    complexPoint = math.complex x, y
    current = complexPoint
    level = 0

    while level < threshold
      current = math.add(math.pow(current, 2), complexPoint)
      break if Math.pow(current.re, 2) + Math.pow(current.im, 2)  > 4
      level++

    return level

  level: level
