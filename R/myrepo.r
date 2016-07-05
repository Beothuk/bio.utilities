#' @export
#set repository
#'changed to function, since it was working as part of a package
myrepo <-function(){
 myrepo = getOption('repos')
       myrepo["CRAN"] = 'http://stat.ethz.ch/CRAN/'
       options(repos = myrepo)
       rm(myrepo)
}