## func_phyloD

phyloD = function(my.tree, my.smokelist){
  
  my.tree$node.label = NULL
  
  phyloD_match = comparative.data(my.tree, my.smokelist, "Species_phylo")
  
  phyloD = phylo.d(phyloD_match, binvar= smoke_summ, permut=1000)
  
  phyloD
  
}
  
