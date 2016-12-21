#' @title Rsquared_glm
#' @description unknown
#' @family abysmally documented
#' @author  unknown, \email{<unknown>@@dfo-mpo.gc.ca}
#' @export
  Rsquared_glm <- function(o) { 
    typ <- matrix(c(
            "Logit: log(mu/(1 - mu))", 
            "Log: log(mu)", 
            "Identity: mu",
            "Binomial: mu(1-mu)", 
            "Identity: mu", 
            "Constant: 1" 
            ), 2, 3, byrow=T) 
    # typ is matrix of supported link and variance combinations
  
    # Remainder of code is for binomial and poisson families 
    # (perhaps with provision for overdispersion) 
    
    n <- length(o$residuals) # number of observations

    R2 <- ( 1 - exp( (o$deviance - o$null.deviance)/n ) ) / ( 1 - exp( -o$null.deviance/n ) )
    names(R2) <- "pseudo.Rsquared"
    R2
  } 

