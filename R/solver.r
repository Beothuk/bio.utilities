solver = function(pars,fn,hess=TRUE,...)
{
  fit = optim(pars,fn,hessian=hess,...)
  if(hess){
    fit$VarCov = solve(fit$hessian)             #Variance-Covariance
    fit$SDs = sqrt(diag(fit$V))                 #Standard deviations
    fit$Correlations = fit$V/(fit$S %o% fit$S)  #Parameter correlation
  }            
  return(fit)
}
