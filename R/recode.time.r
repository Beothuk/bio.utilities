#' @title recode.time
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  recode.time = function(x, type, delta=1, vector=F, t0=NULL) {

    if (vector) x$yr = x

    i.two = 1983
    i.one = 0
    i.min = range( x$yr )[1]
    i.max = range( x$yr )[2]

    if (type=="annual") {} # nothing to do
    if (type=="decadal") x$yr = floor(x$yr / 10) * 10
    if (type=="annualsmoothed" ) {
      i = which (x$yr <= (t0+delta)) & (x$yr >= (t0-delta))
      x$yr[i] = t0
    }

    if (type=="3yrunning") {
      delta = 1
      out = NULL
      for (i in sort(unique(as.numeric(as.character(x$yr))))) {
        z = x[(x$yr <= (i+delta)) & (x$yr >= (i-delta)) ,]
        z$yr = i
        out = rbind (out, z)
      }
      x = out
    }

    if (type=="ecnasap.contrast") {
      pre  = c(1975:1979)
      post = c(1990:1994)
      x$yr[x$yr %in% pre] = 1975
      x$yr[x$yr %in% post] = 1990
      x = x[ x$yr %in% unique(c(pre, post)) , ]
    }

    if (type=="five") {
      br = seq(from=1950, to=2010, by= 5)
      for (u in 1:length(br)) x$yr[x$yr >= br[u] & x$yr< br[u+1]] = br[u]
    }

    if (type=="nao") {
      all.years = unique(x$yr)
      positive.nao =  c(1974,1975,1976,1991,1992,1993,1994)
      negative.nao =  c(1979, 1980, 1987, 1988)
      neutral.nao  = setdiff(all.years, c(positive.nao, negative.nao))
      x$yr[x$yr %in% negative.nao] = -1
      x$yr[x$yr %in% positive.nao] =  1
      x$yr[x$yr %in% neutral.nao ] =  0
    }

    if (type=="two") {
      x$yr[x$yr< i.two] = i.two-1
      x$yr[x$yr>=i.two] = i.two
    }
    if (type=="globalaverage") x$yr=1000  # a dummy value
    if (type=="one") x$yr = i.one
    if (type=="ken") {
      x$yr[x$yr <= 1980] = 70.80
      x$yr[(x$yr >= 1981) & (x$yr <= 1992)] = 81.92
      x$yr[(x$yr >= 1993)] = 93.02
    }
    if (type=="ken1990") {
      x=x[x$yr >= 1990 ,]
      x$yr=1990
    }
    if (type=="ken.closure") {
      x$yr[x$yr <= 1986] = 1986
      x$yr[(x$yr > 1986) & (x$yr <=1993)] = 1993
      x$yr[(x$yr > 1993)] = 2002
    }

    if (vector) return(x$yr) else return(x)
  }


