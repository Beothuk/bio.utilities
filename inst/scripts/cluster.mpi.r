#!/usr/bin/env r
library (Rmpi) # calls MPI_Init
rk = mpi.comm.rank(0)
sz = mpi.comm.size(0)
name =  mpi.get.processor.name()
cat("Hello, rank", rk, "size", sz, "on", name, "\n" )


cl <- NULL
ndsvpid <- Sys.getenv("OMPI_MCA_ns_nds_vpid")
if (ndsvpid == "0") {                   # are we master ?
    cl <- makeMPIcluster()
} else {                                # or are we a slave ?
    sink(file="/dev/null")
    slaveLoop(makeMPImaster())
    q()
}

clusterEvalQ(cl, library(RDieHarder))
res <- parLapply(cl, c("mt19937", "mt19937_1999",
                       "mt19937_1998", "R_mersenne_twister"),
                 function(x) {
                     dieharder(rng=x, test="operm5",
                               psamples=100, seed=12345,
                               rngdraws=100000)
                     }
                 )
stopCluster(cl)

pdf("/tmp/snowRDH.pdf")
lapply(res, function(x) plot(x))
dev.off()
print( do.call(rbind, lapply(res, function(x) { x[[1]] } )))

