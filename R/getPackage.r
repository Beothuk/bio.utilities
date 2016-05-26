#load in package if not in lib need to put quotes around name
getPackage <- function(pkg){
  if(!require(pkg, character.only=TRUE)){
    install.packages(pkg, dependencies=TRUE)
     }  
  require(pkg, character.only=TRUE,quietly=T)
}