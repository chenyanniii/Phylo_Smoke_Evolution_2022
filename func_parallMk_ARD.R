
## func_parallMk_ARD
## set the following parameter before run the simulation
## simulation = NSIM * NRUNS
## NSIM = 3
## NRUNS = 5

parallMk_ARD = function(my.tree, my.smoke_responses, my.Q_ARD){
############# stochastic simulation: make.simmap()

###### bundle cores for parallel
## use all the cores has been detected
## could set to lower if use personal computer

setCores <- detectCores() 


###### send packages and parameters to parallel
cl <- parallel::makeCluster(getOption("cl.cores", setCores))
cl.pkg <- parallel::clusterEvalQ(cl, library(phytools))
parallel::clusterExport(cl, deparse(substitute(my.tree)))
parallel::clusterExport(cl, deparse(substitute(my.smoke_responses)))
parallel::clusterExport(cl, deparse(substitute(my.Q_ARD)))
parallel::clusterExport(cl, deparse(substitute(NSIM)))


###### parallel calculation 

my.ARD_Mkparallel <- parallel::parLapply(cl = cl, 1:NRUNS, function(i) {
  make.simmap(my.tree, my.smoke_responses, Q = my.Q_ARD,
              nsim = NSIM)})

###### unbundle the cores
stopCluster(cl)

###### merge parallel results
ARD_Mk_collect <- do.call(c, my.ARD_Mkparallel)
class(ARD_Mk_collect) <- c("multiSimmap", class(ARD_Mk_collect))

ARD_Mk_collect

}


## sample code

# test.parallMk = parallMk_ARD(tree_fire_eco, smoke_responses_fire_eco, Q_ARD_fire_eco)
