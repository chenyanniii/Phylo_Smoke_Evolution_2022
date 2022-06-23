


##########################################################################################
######################## 2.1.0 Preparation of Data #######################################
##########################################################################################

###### trait value: smoke_responses_joint

smokelist_joint_match = smokelist_joint %>% 
  filter(smokelist_joint$Species_phylo %in% tree_joint$tip.label) %>%
  mutate(smoke_resp = ifelse(smoke_summ == 0, "No_Response", "Response"))

rownames(smokelist_joint_match) = smokelist_joint_match$Species_phylo

smoke_responses_joint = setNames(factor(smokelist_joint_match$smoke_resp), rownames(smokelist_joint_match))
#head(smoke_responses_joint)

###### tree: tree_joint_match

tree_joint_match = keep.tip(tree_joint, smokelist_joint_match$Species_phylo)
tree_joint_match = untangle(tree_joint_match, "read.tree")


###### transition matrix: Q_ARD_match

fitARD_match <- fitMk(tree_joint_match, smoke_responses_joint, model = "ARD")

Q_ARD_match <- matrix(NA, length(fitARD_match$states),
            length(fitARD_match$states))
Q_ARD_match[] <- c(0, fitARD_match$rates)[fitARD_match$index.matrix + 1]
diag(Q_ARD_match) <- 0
diag(Q_ARD_match) <- -rowSums(Q_ARD_match)
colnames(Q_ARD_match) <- rownames(Q_ARD_match) <- fitARD_match$states

##########################################################################################
######################## 2.1.1 Preparation for Parallel Environment ######################
##########################################################################################

###### parallel jobs and sim setting
NRUNS <- 128   #128 'runs' of nsim = 8 -> 1024 total simmaps
NSIM <- 8

###### load libraries
packages = c("phytools", "parallel", "viridis")
package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
)

###### bundle cores for parallel
setCores <- detectCores()

###### send packages and parameters to parallel
cl <- parallel::makeCluster(getOption("cl.cores", setCores))
cl.pkg <- parallel::clusterEvalQ(cl, library(phytools))
parallel::clusterExport(cl, "tree_joint_match")
parallel::clusterExport(cl, "smoke_responses_joint")
parallel::clusterExport(cl, "Q_ARD_match")
parallel::clusterExport(cl, "NSIM")

##########################################################################################
######################## 2.1.2 Run the Parallel Computing ################################
##########################################################################################

ARD_Mkparallel <- parallel::parLapply(cl = cl, 1:NRUNS, function(i) {
  make.simmap(tree_joint_match, smoke_responses_joint, Q = Q_ARD_match,
              nsim = NSIM)

})

## unbundle the cores
stopCluster(cl)


##########################################################################################
################## 2.1.3 Collect and Summarize the Parallel Results ######################
##########################################################################################

# Collect all the stochastic maps
ARD_Mk <- do.call(c, ARD_Mkparallel)
class(ARD_Mk) <- c("multiSimmap", class(ARD_Mk))
# Summarize them
ARD_Mk_summary <- summary(ARD_Mk, plot = FALSE)
saveRDS(ARD_Mk_summary, "results/ARD_Mk_summary.rds")
ARD_Mk_summary = readRDS("results/ARD_Mk_summary.rds")



