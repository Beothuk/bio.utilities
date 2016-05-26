#catch given Fishing mortality and Biomass
#useful for  projections

FB2C <- function(F,B) {
	C = B*(exp(F)-1)*exp(-F)
	return(C)
}