findCurvature = function (x, y, eps = 0.02) {
#       generally preferable to using first differences of raw data, 
#because differencing raw data amplifies noise, while appropriate smooths 
#eliminate much of the noise, leaving you with what you most want.   
#Ramsay and Silverman (2005) Functional Data Analysis, 2nd ed. (Springer) 
#suggest that if you want a second derivative, it is often wise to use 
#quintic splines, because then the second derivative are cubic splines.   
#(The first derivative of a spline of order k is a spline of order k-1.)  

       print('aka second derivative via splines--not done')
    


        sp <- loess( y~x ,degree=5)
        xl = data.frame(x = seq(min(x),max(x),by=eps))
        yl = predict(sp,newdata.xl)

        yp = diff(yl)/diff(xl)
        dd1 <- loess(xp, yp,degree =4 )
        

    D1 <- predict(sp, x, deriv = 1)$y
   
        sp <- smooth.spline(x, D1)
        sp <- smooth.spline(x, D1, spar = offset + sp$spar)
        x <- sort(x)
    list(x = x, y = predict(sp, x, deriv = 1)$y)
}
