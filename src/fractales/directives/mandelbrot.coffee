###*
  @ngdoc directive
  @name Mandelbrot
  @module %module%.fractales
  @description

  Display a canvas with Mandelbrot set
###

angular.module '%module%.fractales'
.directive 'mandelbrot', ($timeout, Mandelbrot) ->
  restrict: 'E'
  scope:
    height: '='
    width: '='
    iterations: '='
  templateUrl: 'fractales/views/mandelbrot.html'
  link: (scope, el, attrs) ->
    canvas = el.children()[0].getContext '2d'
    updateCanvas = ->
      imageData = canvas.createImageData 500, 500
      for x in _.range(0,500)
        for y in _.range(0,500)
          imageData.data[(500 * y + x) * 4] = (Mandelbrot.level (x/125 - 3), (y/125 - 2), scope.iterations) * 255/scope.iterations
          imageData.data[(500 * y + x) * 4 + 3] = 555
      canvas.putImageData imageData, 0, 0

    $timeout updateCanvas, 100
    scope.$watch 'iterations', -> updateCanvas()
