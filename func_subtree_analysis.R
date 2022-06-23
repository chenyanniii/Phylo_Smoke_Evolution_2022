

################################ func_subtree_analysis ##################################

#### The following parameters should be defined:
## NSIM = 8
## NRUNS = 128

## cols = c("blue", "red")
## names(cols) = levels(smoke_responses_joint)

subtree_analysis = function(spp1, spp2, master.tree, master.smokelist){
  
  ############# extract subtree
  subtree = extract_subtree(spp1, spp2, master.tree)
  
  ############# extract trait value
  
  smokelist_subtree = func_extract_smokelist(master.smokelist, subtree)
  
  smoke_responses_subtree = func_extract_smoke_responses(master.smokelist, subtree)
  
  ############# phylogenetic signal
  
  phyloD_subtree = phyloD(subtree, smokelist_subtree)
  
  print(phyloD_subtree)
  
  pdf(file = file.path("results", paste0("phyloD_", spp1, "_", spp2,".pdf")))
  
  plot(phyloD_subtree)
  
  graphics.off()
  
########## ancestral state reconstruction ##########
  
  ############# transition rate
  Q_ARD_subtree = Q_ARD_matrix(subtree, smoke_responses_subtree)
  
  ############# stochastic simulation: make.simmap()
  
  ARD_Mk_subtree = parallMk_ARD(subtree, smoke_responses_subtree, Q_ARD_subtree)
  
  ############# summary multiSimmap
  
  ARD_Mk_subtree_summary <- summary(ARD_Mk_subtree, plot = FALSE)
  
  ############# display results
  
  densityMap_subtree = densityMap(ARD_Mk_subtree, states = names(cols), plot = FALSE)
  
  densityMap_subtree = setMap(densityMap_subtree, c("blue",  "red"))
  
  ### save summary map: pie chart at the node
  
  pdf(file = file.path("results", paste0("Simmap_", spp1, "_", spp2,".pdf")))
  
  plot(ARD_Mk_subtree_summary,colors=cols,type="fan",ftype="off")
  
  graphics.off()
  
  ### save density map
  pdf(file = file.path("results", paste0("Density_", spp1, "_", spp2,".pdf")))
  
  plot(densityMap_subtree, lwd=c(2,6), type="fan", ftype = "off")
  
  graphics.off()
  
  ### plot number of changes
  par(mar = c(2, 2, 2, 2))
  
  changes_subtree = density(ARD_Mk_subtree)
  
  pdf(file = file.path("results", paste0("Changes_", spp1, "_", spp2,".pdf")))
  
  plot(changes_subtree)
  
  graphics.off()
}
