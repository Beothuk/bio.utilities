#' @export
#' @title legend.bubble
#' @description couldn't accurately describe
#' @param \code{x} 
#' @param \code{y} defaults to NULL
#' @param \code{maxradius}  defaults to 1
#' @param \code{n} defaults to 3
#' @param \code{round} defaults to 0
#' @param \code{bty} defaults to "o"
#' @param \code{mab} defaults to 1.2
#' @param \code{bg} defaults to NULL
#' @param \code{inset} defaults to 0
#' @param \code{pch} defaults to 21
#' @param \code{pt.bg} defaults to NULL
#' @param \code{txt.cex} defaults to 1
#' @param \code{txt.col} defaults to NULL
#' @param \code{font} defaults to NULL
#' @family  plotting
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
legend.bubble  <- function (x, y = NULL, z, maxradius = 1, n = 3, round = 0, bty = "o", 
                            mab = 1.2, bg = NULL, inset = 0, pch = 21, pt.bg = NULL, 
                            txt.cex = 1, txt.col = NULL, font = NULL, ...) 
{
  if (length(z) == 1) 
    legend <- round((seq(0, sqrt(z), length.out = n + 1)^2)[-1], 
                    round)
  else legend <- round(sort(z), round)
  radius <- maxradius * sqrt(legend)/sqrt(max(legend))
  cex <- 2 * radius/par("cxy")[2]/0.375
  box <- legend.box(x, y, maxradius, mab, inset)
  if (bty == "o") 
    rect(box[1], box[2], box[3], box[4], col = bg)
  x <- (box[1] + box[3])/2
  y <- box[2] - mab * maxradius + maxradius
  for (i in length(radius):1) {
    ri <- radius[i]
    cex <- 2 * ri/par("cxy")[2]/0.375
    points(x, y - ri, cex = cex, pch = pch, bg = pt.bg, ...)
    text(x, y - ri * 2, legend[i], adj = c(0.5, -0.5), cex = txt.cex, 
         col = txt.col, font = font)
  }
}