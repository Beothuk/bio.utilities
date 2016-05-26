	
  Rsquared <- function(o){
    # o is an lm, glm or gam object
    # # one of the three link/variance combinations:
    # (1) log and mu (which is canonical for Poisson),
    # (2) logit and mu(1-mu) (which is canonical for binomial), or
    # (3) identity and constant (which is canonical for gaussian).
    # However these link/variance pairs may have been passed to quasi()
    # to allow for overdispersion.
      UseMethod("Rsquared")
    }

