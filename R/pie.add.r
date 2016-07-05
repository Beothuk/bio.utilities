#' @export
#' @title pie.add
#' @description couldn't accurately describe
#' @param \code{z} 
#' @param \code{x} defaults to 0
#' @param \code{y} defaults to 0
#' @param \code{labels} defaults to names(z)
#' @param \code{radius} defaults to 1
#' @param \code{edges} defaults to 200 
#' @param \code{clockwise} defaults to TRUE
#' @param \code{init.angle} defaults to 90
#' @param \code{density} defaults to NULL
#' @param \code{angle} defaults to 45
#' @param \code{col} defaults to NULL
#' @param \code{border} defaults to NULL
#' @param \code{lty} defaults to NULL
#' @param \code{label.dist} defaults to 1.1
#' @family  plotting
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
pie.add <- function (z, x = 0, y = 0, labels = names(z), radius = 1, edges = 200, 
                     clockwise = TRUE, init.angle = 90, density = NULL, angle = 45, 
                     col = NULL, border = NULL, lty = NULL, label.dist = 1.1, 
                     ...) {
  if (!is.numeric(z) || any(is.na(z) | z < 0)) 
    stop("'z' values must be positive.")
  if (is.null(labels)) 
    labels <- as.character(seq_along(z))
  else labels <- as.graphicsAnnot(labels)
  z <- c(0, cumsum(z)/sum(z))
  dz <- diff(z)
  nz <- length(dz)
  asp <- get.asp()
  if (is.null(col)) 
    col <- if (is.null(density)) 
      c(rainbow(8,alpha=0.5))
  else par("fg")
  if (!is.null(col)) 
    col <- rep_len(col, nz)
  if (!is.null(border)) 
    border <- rep_len(border, nz)
  if (!is.null(lty)) 
    lty <- rep_len(lty, nz)
  angle <- rep(angle, nz)
  if (!is.null(density)) 
    density <- rep_len(density, nz)
  twopi <- if (clockwise) 
    -2 * pi
  else 2 * pi
  t2xy <- function(t) {
    t2p <- twopi * t + init.angle * pi/180
    list(x = asp * radius * cos(t2p) + x, y = radius * sin(t2p) + 
           y)
  }
  for (i in 1L:nz) {
    n1 <- max(2, floor(edges * dz[i]))
    P <- t2xy(seq.int(z[i], z[i + 1], length.out = n1))
    
    polygon(c(P$x, 0 + x), c(P$y, 0 + y), density = density[i], 
            angle = angle[i], border = border[i], col = col[i], 
            lty = lty[i])
    P <- t2xy(mean(z[i + 0:1]))
    lab <- as.character(labels[i])
    if (!is.na(lab) && nzchar(lab)) {
      text(label.dist * (P$x - x) + x, label.dist * (P$y - 
                                                       y) + y, labels[i], xpd = TRUE, adj = ifelse(P$x - 
                                                                                                     x < 0, 1, 0), ...)
    }
  }
}