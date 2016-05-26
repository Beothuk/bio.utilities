#set repository
 myrepo = getOption('repos')
       myrepo["CRAN"] = 'http://stat.ethz.ch/CRAN/'
       options(repos = myrepo)
       rm(myrepo)