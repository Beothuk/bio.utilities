pressure2Depth <- function (pressure, lat = 45) {
		#Unesco 1983. Algorithms for computation of fundamental properties of seawater, 1983
    lat <- lat * 0.0174532925199433
    x <- sin(lat)^2
    gr <- 9.780318 * (1 + (0.0052788 + 2.36e-05 * x) * x) + 1.092e-06 * pressure
    d <- (((-1.82e-15 * pressure + 2.279e-10) * pressure - 2.2512e-05) * 
        pressure + 9.72659) * pressure/gr
      
    return(d)
}
