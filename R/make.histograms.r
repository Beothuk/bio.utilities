#' @title make.histograms
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  make.histograms = function(set, det, hvar="cw", breaks=NULL) {
    nbins = length(breaks)-1
    sids = sort(unique(set$sid))
    nsids = length(sids)
    out = matrix(data=0, nrow=nsids, ncol=nbins)
    for (sid in 1:nsids) {
        det1 = det[ which(det$sid==sids[sid]), ]
        hi = hist(det1[,hvar], breaks=breaks, plot=F)
        out[sid,] = hi$counts / set$sa[ which(set$sid==sids[sid])]
    }
    rownames(out) = sids
    colnames(out) = breaks[-1]
    return(out)
  }


