#useage
#data(landings)
#data(coast)
#xlim <- c(-12,-5)
#ylim <- c(50,56)
#xyz <- make.xyz(landings$Lon,landings$Lat,landings$LiveWeight,landings$Species)
#col <- rainbow(5)
#basemap(xlim, ylim, main = "Species composition of gadoid landings")
#draw.shape(coast, col="cornsilk")
#draw.pie(xyz$x, xyz$y, xyz$z, radius = 0.3, col=col)
#legend.pie(-13.25,54.8,labels=c("cod","had","hke","pok","whg"), radius=0.3, bty="n", col=col,
# cex=0.8, label.dist=1.3)
#legend.z <- round(max(rowSums(xyz$z,na.rm=TRUE))/10^6,0)
#legend.bubble(-13.25,55.5,z=legend.z,round=1,maxradius=0.3,bty="n",txt.cex=0.6)
#text(-12.25,56,"landings (kt)",cex=0.8) 

draw.pie <- function (x, y, z, radius, scale = T, labels = NA, silent = TRUE, 
    ...) 
{
    nx <- length(x)
    nz <- dim(z)[2]
    if (length(y) != nx) 
        stop("x and y should be vectors of the same length")
    if (length(dim(z)) != 2) 
        stop("z should be a 2-dimensional array")
    if (dim(z)[1] != nx) 
        stop("the number of rows in of z should match as the length of x and y")
    if (sum(z, na.rm = T) == 0) 
        stop("z has no data")
    maxsumz <- max(rowSums(z), na.rm = T)
    #pm <- setProgressMsg(1, nx)
    for (i in 1:nx) {
        xi <- x[i]
        yi <- y[i]
        zi <- z[i, ]
        zi <- ifelse(is.na(zi), 0, zi)
        if (length(radius) > 1) 
            radiusi <- radius[i]
        else radiusi = radius
        if (scale & length(radius) == 1) 
            radiusi <- radius * sqrt(sum(zi, na.rm = T))/sqrt(maxsumz)
        if (sum(zi) > 0) 
            add.pie(zi, xi, yi, labels, radius = radiusi, ...)
        if (!silent) 
            iw=11
            #pm <- progressMsg(pm, i)
    }
}

add.pie <- function (z, x = 0, y = 0, labels = names(z), radius = 1, edges = 200, 
    clockwise = TRUE, init.angle = 90, density = NULL, angle = 45, 
    col = NULL, border = NULL, lty = NULL, label.dist = 1.1, 
    ...) {
    if (!is.numeric(z) || any(is.na(z) | z < 0)) 
        stop("'z' values must be positive.")
    if (is.null(labels)) 
        labels <- as.character(seq_along(z))
    else labels <- as.graphicsAnnot(labels)
    z <- c(0, cumsum(z)/sum(z))
    dz <- diff(z)
    nz <- length(dz)
    asp <- get.asp()
    if (is.null(col)) 
        col <- if (is.null(density)) 
            c(rainbow(8,alpha=0.5))
        else par("fg")
    if (!is.null(col)) 
        col <- rep_len(col, nz)
    if (!is.null(border)) 
        border <- rep_len(border, nz)
    if (!is.null(lty)) 
        lty <- rep_len(lty, nz)
    angle <- rep(angle, nz)
    if (!is.null(density)) 
        density <- rep_len(density, nz)
    twopi <- if (clockwise) 
        -2 * pi
    else 2 * pi
    t2xy <- function(t) {
        t2p <- twopi * t + init.angle * pi/180
        list(x = asp * radius * cos(t2p) + x, y = radius * sin(t2p) + 
            y)
    }
    for (i in 1L:nz) {
        n1 <- max(2, floor(edges * dz[i]))
        P <- t2xy(seq.int(z[i], z[i + 1], length.out = n1))
        
        polygon(c(P$x, 0 + x), c(P$y, 0 + y), density = density[i], 
            angle = angle[i], border = border[i], col = col[i], 
            lty = lty[i])
        P <- t2xy(mean(z[i + 0:1]))
        lab <- as.character(labels[i])
        if (!is.na(lab) && nzchar(lab)) {
            text(label.dist * (P$x - x) + x, label.dist * (P$y - 
                y) + y, labels[i], xpd = TRUE, adj = ifelse(P$x - 
                x < 0, 1, 0), ...)
        }
    }
}


legend.pie <- function (x, y = NULL, z = NULL, labels, radius = 1, bty = "o", 
    mab = 1.2, bg = NULL, inset = 0, ...) 
{
    if (is.null(z)) 
        z <- rep(1, length.out = length(labels))
    box <- legend.box(x, y, radius, mab, inset)
    if (bty == "o") 
        rect(box[1], box[2], box[3], box[4], col = bg)
    x <- (box[1] + box[3])/2
    y <- box[4] + mab * radius
    add.pie(z, x, y, labels, radius, ...)
}

get.asp <- function() {
	    pin <- par("pin")
    usr <- par("usr")
    asp <- (pin[2]/(usr[4] - usr[3]))/(pin[1]/(usr[2] - usr[1]))
    return(asp)

}

legend.box <- function (x, y = NULL, maxradius, mab = 1.2, inset = 0, double = F) 
{
    auto <- if (is.character(x)) 
        match.arg(x, c("bottomright", "bottom", "bottomleft", 
            "left", "topleft", "top", "topright", "right", "center"))
    else NA
    asp <- get.asp()
    h <- mab * 2 * maxradius
    w <- h * asp
    if (double) 
        h <- h * 2
    usr <- par("usr")
    inset <- rep(inset, length.out = 2)
    if (!is.na(auto)) {
        insetx <- inset[1L] * (usr[2L] - usr[1L])
        left <- switch(auto, bottomright = , topright = , right = usr[2L] - 
            w - insetx, bottomleft = , left = , topleft = usr[1L] + 
            insetx, bottom = , top = , center = (usr[1L] + usr[2L] - 
            w)/2)
        insety <- inset[2L] * (usr[4L] - usr[3L])
        top <- switch(auto, bottomright = , bottom = , bottomleft = usr[3L] + 
            h + insety, topleft = , top = , topright = usr[4L] - 
            insety, left = , right = , center = (usr[3L] + usr[4L] + 
            h)/2)
    }
    else {
        left <- x - 1.2 * asp * maxradius
        top <- y + 1.2 * maxradius
    }
    return(c(left, top, left + w, top - h))
}


legend.bubble  <- function (x, y = NULL, z, maxradius = 1, n = 3, round = 0, bty = "o", 
    mab = 1.2, bg = NULL, inset = 0, pch = 21, pt.bg = NULL, 
    txt.cex = 1, txt.col = NULL, font = NULL, ...) 
{
    if (length(z) == 1) 
        legend <- round((seq(0, sqrt(z), length.out = n + 1)^2)[-1], 
            round)
    else legend <- round(sort(z), round)
    radius <- maxradius * sqrt(legend)/sqrt(max(legend))
    cex <- 2 * radius/par("cxy")[2]/0.375
    box <- legend.box(x, y, maxradius, mab, inset)
    if (bty == "o") 
        rect(box[1], box[2], box[3], box[4], col = bg)
    x <- (box[1] + box[3])/2
    y <- box[2] - mab * maxradius + maxradius
    for (i in length(radius):1) {
        ri <- radius[i]
        cex <- 2 * ri/par("cxy")[2]/0.375
        points(x, y - ri, cex = cex, pch = pch, bg = pt.bg, ...)
        text(x, y - ri * 2, legend[i], adj = c(0.5, -0.5), cex = txt.cex, 
            col = txt.col, font = font)
    }
}

make.xyz <- function (x, y, z, group, FUN = sum, ...) 
{
    Z <- tapply(z, list(paste(x, y, sep = ", "), group), FUN, 
        ...)
    Z <- ifelse(is.na(Z), 0, Z)
    XY <- rownames(Z)
    tempfun <- function(XY, i) {
        as.numeric(unlist(lapply(strsplit(XY, ", "), function(x) x[i])))
    }
    X <- tempfun(XY, 1)
    Y <- tempfun(XY, 2)
    return(list(x = X, y = Y, z = Z))
}



