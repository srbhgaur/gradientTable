#' Create gradient tables
#'
#' gradientTable(iris)
#'
#' @import htmlwidgets
#'
#' @export
gradientTable <- function(indata, colstoColor=c(), width = NULL, height = NULL) {
  cols = colnames(indata)
  if(length(colstoColor) < 1){ colstoColor=cols } # if unspecified,color all columns
  #Add Colors
  for (x in colstoColor) {
        indata[paste0(x,".Color")] <- genGradient(indata[x][[1]])
  }

  # forward options using x
  x = list(
    indata = jsonlite::toJSON(indata),
    cols = cols
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


#' custom html function for gradientTable
#' @import htmltools
gradientTable_html <- function(id, style, class, ...){
  tagList(
    tags$div( id = id, class = class, style = style
              ,tags$div(class = "chart-main",id="intable")
    )
  )
}

genGradient<-function(x,type="gradient",palette="Blues"){
  if (is.factor(x)) {
    n=length(levels(x))
    labels <- RColorBrewer::brewer.pal(n, "Accent")
    cut(ecdf(x)(x),c(0:n)/n,labels=labels)
  } else {
    labels <- c("#FFFFFF", RColorBrewer::brewer.pal(9, palette))
    cut(ecdf(x)(x),c(0:10)/10,labels=labels)
  }
}
