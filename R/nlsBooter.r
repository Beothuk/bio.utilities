nlsBooter<-function (nls, data1,niter = 999,Qlow1, Qhigh1) 
{
    if (!inherits(nls, "nls")) 
        stop("Use only with 'nls' objects")
            data2 <- data1
    fitted1 <- fitted(nls)
    resid1 <- resid(nls)
    var1 <- all.vars(formula(nls)[[2]])
    l1 <- lapply(1:niter, function(i) {
        data2[, var1] <- fitted1 + sample(scale(resid1, scale = FALSE), 
            replace = TRUE)
        nls2 <- try(update(nls, start = as.list(coef(nls)), data = data2), 
            silent = TRUE)
        if (inherits(nls2, "nls")) 
            return(list(coef = coef(nls2), rse = summary(nls2)$sigma))
    })
    if (sum(sapply(l1, is.null)) > niter/2) 
        stop(paste("Procedure aborted: the fit only converged in", 
            round(sum(sapply(l1, is.null))/niter), "% during bootstrapping"))
    tabboot <- sapply(l1[!sapply(l1, is.null)], function(z) z$coef)
    rseboot <- sapply(l1[!sapply(l1, is.null)], function(z) z$rse)
    recapboot <- t(apply(tabboot, 1, quantile, c(0.5, Qlow1, 
        Qhigh1)))
        
    colnames(recapboot) <- c("Median", Qlow1*100, Qhigh1*100)
    serr <- sum(sapply(l1, is.null))
    if (serr > 0) 
        warning(paste("The fit did not converge", serr, "times during bootstrapping"))
    listboot <- list(coefboot = t(tabboot), rse = rseboot, bootCI = recapboot)
    class(listboot) <- "nlsBoot"
    return(listboot)
}
