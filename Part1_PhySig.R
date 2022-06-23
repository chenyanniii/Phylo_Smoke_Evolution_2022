

#######################################################################################
################### 1.0 Order Smoke List According to Tree ############################
#######################################################################################
#read in data frame with germination and region data

#df_joint = smokelist_joint %>% mutate(Taxa = sapply(strsplit(Species_phylo, "_"), function(x) paste(x[1:2], collapse = " "))) 

#df_ontree_lst = df_joint %>% filter(df_joint$Taxa %in% sp_ontree$species) 

#df_ontree = df_ontree_lst


#row.names(df_ontree) <- c(df_ontree$Species_phylo) 
#df_ontree <- df_ontree[,-3]

#picante::match.phylo.data(tree_ontree, df_ontree)
#sort(tree_ontree$tip.label, decreasing = FALSE)


#######################################################################################
############################ 1.1 Phylogenetic Signal ###################################
#######################################################################################

################### 3.1 Phylogenetic Signal of 700+ species ############################
###### species are on the tree (bificated)
###### Calculation of Fritz D statistic for phylogenetic signal (phylo.d in caper)
#tree_ontree$node.label = NULL

#germD = caper::comparative.data(tree_ontree, df_ontree_lst, "Species_phylo") 

#phyloD_smoke <- caper::phylo.d(germD, binvar= smoke_summ, permut=1000)
#print(phyloD_smoke)

#pdf(file = file.path("results", paste0("PhyloSignal_smoke.pdf")))
#plot(phyloD_smoke)
#graphics.off()

################### 3.1 Phylogenetic Signal of 1500 + species ############################
tree_joint_match$node.label = NULL
germD_match = caper::comparative.data(tree_joint_match, smokelist_joint_match, "Species_phylo")

phyloD_smoke_match <- caper::phylo.d(germD_match, binvar= smoke_summ, permut=1000)
print(phyloD_smoke_match)

pdf(file = file.path("results", paste0("PhyloSignal_smoke_match.pdf")))
plot(phyloD_smoke_match)
graphics.off()