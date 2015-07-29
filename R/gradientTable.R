#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
gradientTable <- function(message, width = NULL, height = NULL) {

  # forward options using x
  x = list(
    message = message
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'gradientTable',
    x,
    width = width,
    height = height,
    package = 'gradientTable'
  )
}

#' Widget output function for use in Shiny
#'
#' @export
gradientTableOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'gradientTable', width, height, package = 'gradientTable')
}

#' Widget render function for use in Shiny
#'
#' @export
renderGradientTable <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, gradientTableOutput, env, quoted = TRUE)
}
