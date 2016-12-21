#' @export
#' @title pie.legend
#' @description couldnt accurately describe
#' @param \code{x} NULL
#' @param \code{y} defaults to NULL
#' @param \code{z} defaults to NULL
#' @param \code{labels} NULL
#' @param \code{radius} defaults to 1
#' @param \code{bty} defaults to "o" 
#' @param \code{mab} defaults to 1.2
#' @param \code{bg} defaults to NULL 
#' @param \code{inset} defaults to 0
#' @family  plotting
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
pie.legend <- function (x, y = NULL, z = NULL, labels, radius = 1, bty = "o", 
                        mab = 1.2, bg = NULL, inset = 0, ...) 
{
  if (is.null(z)) 
    z <- rep(1, length.out = length(labels))
  box <- legend.box(x, y, radius, mab, inset)
  if (bty == "o") 
    rect(box[1], box[2], box[3], box[4], col = bg)
  x <- (box[1] + box[3])/2
  y <- box[4] + mab * radius
  pie.add(z, x, y, labels, radius, ...)
}