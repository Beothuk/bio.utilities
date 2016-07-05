#' @export
#' @title dstamp
#' @description function to add a datestamp to the bottom right corner of a figure
#' @param \code{txt} 
#' @param \code{pwd} 
#' @param \code{time.} 
#' @family plotting
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
dstamp<- function (txt, pwd = FALSE, time. = TRUE) 
{
    stamp <- function(string = Sys.time(), print = TRUE, plot = TRUE) {
        opar <- par(yaxt = "s", xaxt = "s", xpd = NA)
        on.exit(par(opar))
        plt <- par("plt")
        usr <- par("usr")
        xcoord <- usr[2] + (usr[2] - usr[1])/(plt[2] - plt[1]) * 
            (1 - plt[2]) - 0.6 * strwidth("m")
        ycoord <- usr[3] - diff(usr[3:4])/diff(plt[3:4]) * (plt[3]) + 
            0.6 * strheight("m")
        if (par("xlog")) 
            xcoord <- 10^(xcoord)
        if (par("ylog")) 
            ycoord <- 10^(ycoord)
        text(xcoord, ycoord, string, adj = 1)
        invisible(string)
    }
    date.txt <- if (time.) 
        format(Sys.time())
    else format(Sys.time(), "%Y-%m-%d")
    if (pwd) 
        date.txt <- paste(getwd(), date.txt)
    oldpar <- par(mfrow = c(1, 1), cex = 0.5)
    on.exit(par(oldpar))
    if (!missing(txt)) 
        date.txt <- paste(txt, "   ", date.txt, sep = "")
    stamp(string = date.txt, print = FALSE, plot = TRUE)
    invisible()
}