#' @title myrepo
#' @description set repository - changed to function, since it was working as part of a package
#' @family abysmally documented
#' @author unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
myrepo <-function(){
 myrepo = getOption('repos')
       myrepo["CRAN"] = 'http://stat.ethz.ch/CRAN/'
       options(repos = myrepo)
       rm(myrepo)
}