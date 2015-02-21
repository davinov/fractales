###*
  @ngdoc directive
  @name Mandelbrot
  @module %module%.fractales
  @description

  Display a canvas with Mandelbrot set
###

angular.module '%module%.fractales'
.directive 'mandelbrot', ($window, Mandelbrot) ->
  restrict: 'E'
  scope:
    iterations: '='
  templateUrl: 'fractales/views/mandelbrot.html'
  link: (scope, el, attrs) ->
    canvasElement = el.children()[0]
    canvas = canvasElement.getContext '2d'
    [height, width] = [undefined]

    updateCanvas = ->
      return if not (_.isNumber(height) and _.isNumber(width))
      imageData = canvas.createImageData height, width

      xScale = d3.scale.linear()
        .domain [0, width]
        .range [-2, 0.5]
      yScale = d3.scale.linear()
        .domain [0, height]
        .range [-1.5, 1.5]

      for y in _.range 0, height
        for x in _.range 0, width
          point = 4 * (height * y + x)
          imageData.data[point] = (Mandelbrot.level xScale(x), yScale(y), scope.iterations) * 255 / scope.iterations
          imageData.data[point + 1] = 0
          imageData.data[point + 2] = 0
          imageData.data[point + 3] = 255
      canvas.putImageData imageData, 0, 0

    resizeCanvas = ->
      window.requestAnimationFrame ->
        canvasElement.height = height = el.height()
        canvasElement.width = width = el.width()
        updateCanvas()

    resizeCanvas()
    angular.element($window).bind 'resize', resizeCanvas
    scope.$watch 'iterations', updateCanvas
